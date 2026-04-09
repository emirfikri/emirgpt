import 'package:emirgpt/models/export_models.dart';

class BookingAiReplyRaw {
  final BookingAiReplyResponse reply;
  final VenuePromptConfirmation? venuePromptConfirmation;
  final SuggestedSlots? suggestedSlots;

  BookingAiReplyRaw({
    required this.reply,
    this.venuePromptConfirmation,
    this.suggestedSlots,
  });

  Map<String, dynamic> toJson() => {
    'reply': reply.toJson(),
    'venuePromptConfirmation': venuePromptConfirmation?.toJson(),
    'suggestedSlots': suggestedSlots?.toJson(),
  };

  factory BookingAiReplyRaw.fromJson(Map<String, dynamic> json) {
    return BookingAiReplyRaw(
      reply: BookingAiReplyResponse.fromJson(json["reply"]),
      venuePromptConfirmation: json["venuePromptConfirmation"] != null
          ? VenuePromptConfirmation.fromJson(json["venuePromptConfirmation"])
          : null,
      suggestedSlots: json["suggestedSlots"] != null
          ? SuggestedSlots.fromJson({"suggestedSlots": json["suggestedSlots"]})
          : null,
    );
  }

  BookingAiReplyRaw copyWith({
    BookingAiReplyResponse? reply,
    VenuePromptConfirmation? venuePromptConfirmation,
    SuggestedSlots? suggestedSlots,
  }) {
    return BookingAiReplyRaw(
      reply: reply ?? this.reply,
      venuePromptConfirmation:
          venuePromptConfirmation ?? this.venuePromptConfirmation,
      suggestedSlots: suggestedSlots ?? this.suggestedSlots,
    );
  }
}
