import 'package:emirgpt/models/response/booking_ai_reply_raw.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isThinking;
  final bool isAnswered;
  final BookingAiReplyRaw? replyRaw;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isThinking = false,
    this.isAnswered = false,
    this.replyRaw,
  });

  Map<String, dynamic> toJson() => {
    'text': text,
    'isUser': isUser,
    'timestamp': timestamp.toIso8601String(),
    'isThinking': isThinking,
    'isAnswered': isAnswered,
    'replyRaw': replyRaw?.toJson(),
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    BookingAiReplyRaw? replyRaw;
    try {
      replyRaw = json['replyRaw'] != null
          ? BookingAiReplyRaw.fromJson(json['replyRaw'])
          : null;
    } catch (e) {
      // If parsing fails, set to null to avoid crashes
      replyRaw = null;
    }

    return ChatMessage(
      text: json['text'] ?? '',
      isUser: json['isUser'] ?? false,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
      isThinking: json['isThinking'] ?? false,
      isAnswered: json['isAnswered'] ?? false,
      replyRaw: replyRaw,
    );
  }

  ChatMessage copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
    bool? isThinking,
    bool? isAnswered,
    BookingAiReplyRaw? replyRaw,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      isThinking: isThinking ?? this.isThinking,
      isAnswered: isAnswered ?? this.isAnswered,
      replyRaw: replyRaw ?? this.replyRaw,
    );
  }
}
