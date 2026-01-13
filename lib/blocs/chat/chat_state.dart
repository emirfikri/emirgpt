import '/models/export_models.dart';

abstract class ChatState {
  final List<ChatMessage> messages;
  const ChatState(this.messages);
}

class ChatInitial extends ChatState {
  const ChatInitial() : super(const []);
}

class ChatLoading extends ChatState {
  const ChatLoading(List<ChatMessage> messages) : super(messages);
}

class ChatSuccess extends ChatState {
  const ChatSuccess(List<ChatMessage> messages) : super(messages);
}

class ChatError extends ChatState {
  final String error;
  const ChatError(this.error, List<ChatMessage> messages) : super(messages);
}

class ChatStreaming extends ChatState {
  final List<ChatMessage> messages;

  ChatStreaming(this.messages) : super(messages);
}
