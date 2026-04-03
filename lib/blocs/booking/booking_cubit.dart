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

    try {
      final fullResponse = await repository.sendMessage(text);
      final replyText = fullResponse.reply.reply;

      const int chunkSize = 20;
      const Duration frameDelay = Duration(milliseconds: 2);
      String buffer = '';

      for (int i = 0; i < replyText.length; i += chunkSize) {
        buffer += replyText.substring(
          i,
          (i + chunkSize).clamp(0, replyText.length),
        );

        updatedMessages[updatedMessages.length - 1] = updatedMessages.last
            .copyWith(text: buffer, isThinking: false, replyRaw: fullResponse);

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

  Future<void> sendConfirmBooking(
    VenuePromptConfirmation venuePromptConfirmation,
  ) async {
    final now = DateTime.now();

    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(
        ChatMessage(text: '', isUser: false, timestamp: now, isThinking: true),
      );

    emit(BookingStreaming(updatedMessages));
    BookingStorage.save(updatedMessages);
    try {
      final fullResponse = await repository.sendConfirmBooking(
        venuePromptConfirmation,
      );
      print(fullResponse.runtimeType);
      print('Booking confirm response: $fullResponse');

      final replyText = fullResponse.reply;

      const int chunkSize = 20;
      const Duration frameDelay = Duration(milliseconds: 2);
      String buffer = '';

      for (int i = 0; i < replyText.length; i += chunkSize) {
        buffer += replyText.substring(
          i,
          (i + chunkSize).clamp(0, replyText.length),
        );

        updatedMessages[updatedMessages.length - 1] = updatedMessages.last
            .copyWith(text: buffer, isThinking: false);

        BookingStorage.save(updatedMessages);
        emit(BookingStreaming(List.from(updatedMessages)));

        await Future.delayed(frameDelay);
      }

      emit(BookingSuccess(updatedMessages));
    } catch (e) {
      print('Failed to get booking response: $e');
    }
  }

  void updateMessagesIndex(int index) {
    final messages = List<ChatMessage>.from(state.messages);
    if (index < 0 || index >= messages.length) return;
    final message = messages[index];
    messages[index] = message.copyWith(isAnswered: true);
    BookingStorage.save(messages);
    emit(UpdateMessages(messages));
  }

  void clearHistory() {
    BookingStorage.clear();
    emit(BookingInitial());
  }

  void retryLast() {
    if (state.messages.isNotEmpty) {
      final lastUserMessage = state.messages.lastWhere((m) => m.isUser).text;
      sendMessage(lastUserMessage);
    }
  }

  void retry() {
    retryLast();
  }
}
