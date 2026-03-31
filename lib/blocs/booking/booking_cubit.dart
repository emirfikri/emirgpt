import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/storage/booking_storage.dart';
import '../../models/export_models.dart';
import '../../repository/booking_repository.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingChatState> {
  final BookingRepository repository;

  BookingCubit(this.repository) : super(BookingInitial()) {
    final savedMessages = BookingStorage.load();
    if (savedMessages.isNotEmpty) {
      emit(BookingSuccess(savedMessages));
    }
  }

  Future<void> sendMessage(String text) async {
    final now = DateTime.now();

    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(text: text, isUser: true, timestamp: now))
      ..add(
        ChatMessage(text: '', isUser: false, timestamp: now, isThinking: true),
      );

    emit(BookingStreaming(updatedMessages));
    BookingStorage.save(updatedMessages);

    final fullResponse = await repository
        .sendMessage(text)
        .then((bookingReply) => bookingReply.reply.reply);
    print('fullResponse: $fullResponse');
    try {
      final fullResponse = await repository
          .sendMessage(text)
          .then((bookingReply) => bookingReply.reply.reply);

      const int chunkSize = 20;
      const Duration frameDelay = Duration(milliseconds: 2);
      String buffer = '';

      for (int i = 0; i < fullResponse.length; i += chunkSize) {
        buffer += fullResponse.substring(
          i,
          (i + chunkSize).clamp(0, fullResponse.length),
        );

        updatedMessages[updatedMessages.length - 1] = updatedMessages.last
            .copyWith(text: buffer, isThinking: false);

        BookingStorage.save(updatedMessages);
        emit(BookingStreaming(List.from(updatedMessages)));

        await Future.delayed(frameDelay);
      }

      emit(BookingSuccess(updatedMessages));
    } catch (e) {
      updatedMessages.removeLast();
      emit(BookingError('Failed to get booking response', updatedMessages));
    }
  }

  void retryLast() {
    if (state.messages.isNotEmpty) {
      final lastUserMessage = state.messages.lastWhere((m) => m.isUser).text;
      sendMessage(lastUserMessage);
    }
  }

  void clearHistory() {
    BookingStorage.clear();
    emit(BookingInitial());
  }

  void retry() {
    retryLast();
  }
}
