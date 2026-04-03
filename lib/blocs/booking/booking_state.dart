import '../../models/export_models.dart';

abstract class BookingChatState {
  final List<ChatMessage> messages;
  const BookingChatState(this.messages);
}

class BookingInitial extends BookingChatState {
  const BookingInitial() : super(const []);
}

class BookingLoading extends BookingChatState {
  const BookingLoading(List<ChatMessage> messages) : super(messages);
}

class BookingSuccess extends BookingChatState {
  const BookingSuccess(List<ChatMessage> messages) : super(messages);
}

class BookingError extends BookingChatState {
  final String error;
  const BookingError(this.error, List<ChatMessage> messages) : super(messages);
}

class BookingStreaming extends BookingChatState {
  final List<ChatMessage> messages;

  BookingStreaming(this.messages) : super(messages);
}

class UpdateMessages extends BookingChatState {
  final List<ChatMessage> messages;

  UpdateMessages(this.messages) : super(messages);
}
