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
        ChatMessage(text: '', isUser: false, timestamp: now),
      ); // 👈 placeholder AI message

    emit(ChatStreaming(updatedMessages));
    ChatStorage.save(updatedMessages);
    try {
      final fullResponse = await repository.sendMessage(text);

      String buffer = '';

      for (int i = 0; i < fullResponse.length; i++) {
        buffer += fullResponse[i];

        updatedMessages[updatedMessages.length - 1] = updatedMessages.last
            .copyWith(text: buffer);
        ChatStorage.save(updatedMessages);
        emit(ChatStreaming(List.from(updatedMessages)));
        await Future.delayed(const Duration(milliseconds: 18));
      }
      emit(ChatSuccess(updatedMessages));
    } catch (e) {
      updatedMessages.removeLast(); // remove AI placeholder
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

  void retry() {}
}
