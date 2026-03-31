class BookingAiReplyResponse {
  final String? intent;
  final String? sport;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? time;
  final List<String>? venueId;
  final List<String>? venueName;
  final String reply;

  BookingAiReplyResponse({
    this.intent,
    this.sport,
    this.startDate,
    this.endDate,
    this.time,
    this.venueId,
    this.venueName,
    required this.reply,
  });

  Map<String, dynamic> toJson() => {
    'intent': intent,
    'sport': sport,
    'startDate': startDate?.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
    'time': time,
    'venueId': venueId,
    'venueName': venueName,
    'reply': reply,
  };

  factory BookingAiReplyResponse.fromJson(Map<String, dynamic> json) {
    return BookingAiReplyResponse(
      intent: json['intent'],
      sport: json['sport'],
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      time: json['time'],
      venueId: json['venueId'] != null
          ? List<String>.from(json['venueId'])
          : null,
      venueName: json['venueName'] != null
          ? List<String>.from(json['venueName'])
          : null,
      reply: json['reply'],
    );
  }

  BookingAiReplyResponse copyWith({
    String? intent,
    String? sport,
    DateTime? startDate,
    DateTime? endDate,
    String? time,
    List<String>? venueId,
    List<String>? venueName,
    String? reply,
  }) {
    return BookingAiReplyResponse(
      intent: intent ?? this.intent,
      sport: sport ?? this.sport,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      time: time ?? this.time,
      venueId: venueId ?? this.venueId,
      venueName: venueName ?? this.venueName,
      reply: reply ?? this.reply,
    );
  }
}
