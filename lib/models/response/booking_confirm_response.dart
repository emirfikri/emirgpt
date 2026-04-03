class BookingConfirmResponse {
  final bool success;
  final BookingData? data;
  final String reply;

  BookingConfirmResponse({
    required this.success,
    this.data,
    required this.reply,
  });

  factory BookingConfirmResponse.fromJson(Map<String, dynamic> json) {
    return BookingConfirmResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
      reply: json['reply'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'data': data?.toJson(), 'reply': reply};
  }
}

class BookingData {
  final String userId;
  final String userName;
  final String venueId;
  final String venueName;
  final TimestampData startDate;
  final TimestampData endDate;
  final TimestampData createdAt;
  final TimestampData updatedAt;
  final String notes;
  final double pricePerHour;
  final String id;
  final String status;

  BookingData({
    required this.userId,
    required this.userName,
    required this.venueId,
    required this.venueName,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.notes,
    required this.pricePerHour,
    required this.id,
    required this.status,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      userId: json['userId']?.toString() ?? '',
      userName: json['userName'] ?? '',
      venueId: json['venueId'] ?? '',
      venueName: json['venueName'] ?? '',
      startDate: TimestampData.fromJson(json['startDate']),
      endDate: TimestampData.fromJson(json['endDate']),
      createdAt: TimestampData.fromJson(json['createdAt']),
      updatedAt: TimestampData.fromJson(json['updatedAt']),
      notes: json['notes'] ?? '',
      pricePerHour: (json['pricePerHour'] ?? 0).toDouble(),
      id: json['id'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'venueId': venueId,
      'venueName': venueName,
      'startDate': startDate.toJson(),
      'endDate': endDate.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      'notes': notes,
      'pricePerHour': pricePerHour,
      'id': id,
      'status': status,
    };
  }
}

class TimestampData {
  final int seconds;
  final int nanoseconds;

  TimestampData({required this.seconds, required this.nanoseconds});

  factory TimestampData.fromJson(Map<String, dynamic> json) {
    return TimestampData(
      seconds: json['_seconds'] ?? 0,
      nanoseconds: json['_nanoseconds'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'_seconds': seconds, '_nanoseconds': nanoseconds};
  }
}
