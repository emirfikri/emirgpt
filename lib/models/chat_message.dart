class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isThinking;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isThinking = false,
  });

  Map<String, dynamic> toJson() => {
    'text': text,
    'isUser': isUser,
    'timestamp': timestamp.toIso8601String(),
    'isThinking': isThinking,
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'],
      isUser: json['isUser'],
      timestamp: DateTime.parse(json['timestamp']),
      isThinking: json['isThinking'] ?? false,
    );
  }

  ChatMessage copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
    bool? isThinking,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      isThinking: isThinking ?? this.isThinking,
    );
  }
}
