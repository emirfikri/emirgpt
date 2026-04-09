import '../../models/export_models.dart';

abstract class BookingChatState {
  final List<ChatMessage> messages;
  const BookingChatState(this.messages);
}

class BookingChatInitial extends BookingChatState {
  const BookingChatInitial() : super(const []);
}

class BookingChatLoading extends BookingChatState {
  const BookingChatLoading(List<ChatMessage> messages) : super(messages);
}

class BookingChatSuccess extends BookingChatState {
  const BookingChatSuccess(List<ChatMessage> messages) : super(messages);
}

class BookingChatError extends BookingChatState {
  final String error;
  const BookingChatError(this.error, List<ChatMessage> messages)
    : super(messages);
}

class BookingChatStreaming extends BookingChatState {
  final List<ChatMessage> messages;

  BookingChatStreaming(this.messages) : super(messages);
}

class UpdateChatMessages extends BookingChatState {
  final List<ChatMessage> messages;

  UpdateChatMessages(this.messages) : super(messages);
}
