import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/storage/booking_storage.dart';
import '../../models/export_models.dart';
import '../../repository/booking_repository.dart';
import 'booking_chat_state.dart';

class BookingChatCubit extends Cubit<BookingChatState> {
  final BookingRepository repository;
  User? currentUser;

  BookingChatCubit(this.repository) : super(const BookingChatInitial()) {
    final savedMessages = BookingStorage.load();
    print('Loaded saved messages: ${savedMessages.length}');
    savedMessages.forEach((msg) {
      print('Message: ${msg.toJson()},  ');
    });
    if (savedMessages.isNotEmpty) {
      emit(BookingChatSuccess(savedMessages));
    }
  }

  Future<void> sendMessage(String text) async {
    final now = DateTime.now();

    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(text: text, isUser: true, timestamp: now))
      ..add(
        ChatMessage(text: '', isUser: false, timestamp: now, isThinking: true),
      );

    emit(BookingChatStreaming(updatedMessages));
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
        emit(BookingChatStreaming(List.from(updatedMessages)));

        await Future.delayed(frameDelay);
      }

      emit(BookingChatSuccess(updatedMessages));
    } catch (e) {
      updatedMessages.removeLast();
      emit(BookingChatError('Failed to get booking response', updatedMessages));
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

    emit(BookingChatStreaming(updatedMessages));
    BookingStorage.save(updatedMessages);
    try {
      final fullResponse = await repository.sendConfirmBooking(
        venuePromptConfirmation,
      );
      final replyText = fullResponse.reply;

      print("sendConfirmBooking == ${replyText}");

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
        emit(BookingChatStreaming(List.from(updatedMessages)));

        await Future.delayed(frameDelay);
      }

      emit(BookingChatSuccess(updatedMessages));
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
    emit(UpdateChatMessages(messages));
  }

  void clearHistory() {
    BookingStorage.clear();
    emit(BookingChatInitial());
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
