class BookingHistory {
  final String id;
  final String userId;
  final String venueName;
  final String venueId;
  final DateTime startDate;
  final DateTime createdAt;
  final String status; // 'confirmed', 'completed', 'cancelled'
  final Map<String, dynamic>? details;

  BookingHistory({
    required this.id,
    required this.userId,
    required this.venueName,
    required this.venueId,
    required this.startDate,
    required this.createdAt,
    this.status = 'confirmed',
    this.details,
  });

  factory BookingHistory.fromJson(Map<String, dynamic> json) {
    return BookingHistory(
      id: json['id'] as String,
      userId: json['userId'] as String,
      venueName: json['venueName'] as String,
      venueId: json['venueId'] as String,
      startDate: _parseDateTime(json['startDate']),
      createdAt: _parseDateTime(json['createdAt']),
      status: json['status'] as String? ?? 'confirmed',
      details: json['details'] as Map<String, dynamic>?,
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) {
      return DateTime.now();
    }

    // Handle Firestore Timestamp objects
    if (value.runtimeType.toString() == '_FirestoreTimestamp' ||
        value.runtimeType.toString() == 'Timestamp') {
      return (value as dynamic).toDate() as DateTime;
    }

    // Handle String ISO8601 format
    if (value is String) {
      return DateTime.parse(value);
    }

    // Handle DateTime directly
    if (value is DateTime) {
      return value;
    }

    // Fallback
    return DateTime.now();
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'venueName': venueName,
    'venueId': venueId,
    'startDate': startDate.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'status': status,
    'details': details,
  };

  BookingHistory copyWith({
    String? id,
    String? userId,
    String? venueName,
    String? venueId,
    DateTime? startDate,
    DateTime? createdAt,
    String? status,
    Map<String, dynamic>? details,
  }) {
    return BookingHistory(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      venueName: venueName ?? this.venueName,
      venueId: venueId ?? this.venueId,
      startDate: startDate ?? this.startDate,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      details: details ?? this.details,
    );
  }
}
