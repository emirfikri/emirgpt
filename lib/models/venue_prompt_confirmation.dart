class VenuePromptConfirmation {
  final String id;
  final String userId;
  final String userName;
  final String venueId;
  final String venueName;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? notes;

  VenuePromptConfirmation({
    required this.id,
    required this.userId,
    required this.userName,
    required this.venueId,
    required this.venueName,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.notes,
  });

  factory VenuePromptConfirmation.fromJson(Map<String, dynamic> json) {
    return VenuePromptConfirmation(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      venueId: json['venueId'] ?? '',
      venueName: json['venueName'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'venueId': venueId,
      'venueName': venueName,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'notes': notes,
    };
  }

  VenuePromptConfirmation copyWith({
    String? id,
    String? userId,
    String? userName,
    String? venueId,
    String? venueName,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
  }) {
    return VenuePromptConfirmation(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      venueId: venueId ?? this.venueId,
      venueName: venueName ?? this.venueName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
    );
  }
}
