import 'package:emirgpt/models/export_models.dart';

class BookingAiReplyRaw {
  final BookingAiReplyResponse reply;
  final VenuePromptConfirmation? venuePromptConfirmation;

  BookingAiReplyRaw({required this.reply, this.venuePromptConfirmation});

  Map<String, dynamic> toJson() => {
    'reply': reply.toJson(),
    'venuePromptConfirmation': venuePromptConfirmation?.toJson(),
  };

  factory BookingAiReplyRaw.fromJson(Map<String, dynamic> json) {
    return BookingAiReplyRaw(
      reply: BookingAiReplyResponse.fromJson(json["reply"]),
      venuePromptConfirmation: json["venuePromptConfirmation"] != null
          ? VenuePromptConfirmation.fromJson(json["venuePromptConfirmation"])
          : null,
    );
  }

  BookingAiReplyRaw copyWith({
    BookingAiReplyResponse? reply,
    VenuePromptConfirmation? venuePromptConfirmation,
  }) {
    return BookingAiReplyRaw(
      reply: reply ?? this.reply,
      venuePromptConfirmation:
          venuePromptConfirmation ?? this.venuePromptConfirmation,
    );
  }
}
