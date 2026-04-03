class VenuePromptConfirmation {
  final String id;
  final String userId;
  final String userName;
  final String venueId;
  final String venueName;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final int pricePerHour;
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
    required this.pricePerHour,
  });

  factory VenuePromptConfirmation.fromJson(Map<String, dynamic> json) {
    return VenuePromptConfirmation(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      venueId: json['venueId'] ?? '',
      venueName: json['venueName'] ?? '',
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : DateTime.now().add(const Duration(hours: 1)),
      status: json['status'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      notes: json['notes'] ?? '',
      pricePerHour: json['pricePerHour'] ?? 10,
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
      'pricePerHour': pricePerHour,
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
    int? pricePerHour,
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
      pricePerHour: pricePerHour ?? this.pricePerHour,
    );
  }
}
