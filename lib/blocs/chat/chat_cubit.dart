import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/storage/chat_storage.dart';
import '../../models/export_models.dart';
import '../../repository/export_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;

  ChatCubit(this.repository) : super(ChatInitial()) {
    final savedMessages = ChatStorage.load();
    if (savedMessages.isNotEmpty) {
      emit(ChatSuccess(savedMessages));
    }
  }

  Future<void> sendMessage(String text) async {
    final now = DateTime.now();

    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(text: text, isUser: true, timestamp: now))
      ..add(
        ChatMessage(
          text: '',
          isUser: false,
          timestamp: now,
          isThinking: true, // 👈 START THINKING
        ),
      );

    emit(ChatStreaming(updatedMessages));
    ChatStorage.save(updatedMessages);

    try {
      final fullResponse = await repository.sendMessage(text);

      const int chunkSize = 20;
      const Duration frameDelay = Duration(milliseconds: 2);
      String buffer = '';

      for (int i = 0; i < fullResponse.length; i += chunkSize) {
        buffer += fullResponse.substring(
          i,
          (i + chunkSize).clamp(0, fullResponse.length),
        );

        updatedMessages[updatedMessages.length - 1] = updatedMessages.last
            .copyWith(
              text: buffer,
              isThinking: false, // 👈 STOP THINKING ON FIRST CHUNK
            );

        ChatStorage.save(updatedMessages);
        emit(ChatStreaming(List.from(updatedMessages)));

        await Future.delayed(frameDelay);
      }

      emit(ChatSuccess(updatedMessages));
    } catch (e) {
      updatedMessages.removeLast();
      emit(ChatError('Failed to get AI response', updatedMessages));
    }
  }

  void retryLast() {
    if (state.messages.isNotEmpty) {
      final lastUserMessage = state.messages.lastWhere((m) => m.isUser).text;
      sendMessage(lastUserMessage);
    }
  }

  void clearHistory() {
    ChatStorage.clear();
    emit(ChatInitial());
  }

  void retry() {
    if (state.messages.isNotEmpty) {
      final lastUserMessage = state.messages.lastWhere((m) => m.isUser).text;
      sendMessage(lastUserMessage);
    }
  }
}
