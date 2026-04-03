import 'package:emirgpt/models/export_models.dart';

import '../core/network/export_api.dart';

class BookingRepository {
  final BookingApiClient bookingApiClient;

  BookingRepository(this.bookingApiClient);

  Future<BookingAiReplyRaw> sendMessage(String message) {
    return bookingApiClient.sendMessage(message);
  }

  Future<BookingConfirmResponse> sendConfirmBooking(
    VenuePromptConfirmation venuePromptConfirmation,
  ) {
    return bookingApiClient.sendConfirmBooking(venuePromptConfirmation);
  }
}
