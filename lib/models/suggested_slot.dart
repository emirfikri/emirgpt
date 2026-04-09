class SuggestedSlot {
  final String venueId;
  final String venueName;
  final DateTime startDate;
  final DateTime endDate;

  SuggestedSlot({
    required this.venueId,
    required this.venueName,
    required this.startDate,
    required this.endDate,
  });

  factory SuggestedSlot.fromJson(Map<String, dynamic> json) {
    return SuggestedSlot(
      venueId: json['venueId'] as String,
      venueName: json['venueName'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'venueId': venueId,
      'venueName': venueName,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}

class SuggestedSlots {
  final List<SuggestedSlot> suggestedSlots;

  SuggestedSlots({required this.suggestedSlots});

  factory SuggestedSlots.fromJson(Map<String, dynamic> json) {
    final rawSlots = json['suggestedSlots'];
    final slots = rawSlots is List ? rawSlots : <dynamic>[];

    return SuggestedSlots(
      suggestedSlots: slots.where((slot) => slot != null).map((slot) {
        if (slot is Map<String, dynamic>) {
          return SuggestedSlot.fromJson(slot);
        }
        if (slot is Map) {
          return SuggestedSlot.fromJson(Map<String, dynamic>.from(slot));
        }
        throw FormatException(
          'Invalid suggested slot item: ${slot.runtimeType}',
        );
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'suggestedSlots': suggestedSlots.map((slot) => slot.toJson()).toList(),
    };
  }
}
