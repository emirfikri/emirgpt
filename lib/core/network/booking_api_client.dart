import 'dart:convert';
import 'package:emirgpt/models/export_models.dart';
import 'package:http/http.dart' as http;

class BookingApiClient {
  static const _baseUrl = 'http://localhost:3000';

  Future<BookingAiReplyRaw> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/booking/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to get booking response');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    print(' BookingApiClient sendMessage response data: $data');
    return BookingAiReplyRaw.fromJson(data);
  }

  Future<BookingConfirmResponse> sendConfirmBooking(
    VenuePromptConfirmation venuePromptConfirmation,
  ) async {
    late final http.Response response;
    try {
      response = await http.post(
        Uri.parse('$_baseUrl/api/booking/book-confirm'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(venuePromptConfirmation.toJson()),
      );
    } catch (e) {
      throw Exception(
        'Failed to fetch booking confirm: $e (uri=$_baseUrl/api/booking/book-confirm)',
      );
    }
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to confirm booking ${response.statusCode}: ${response.body}',
      );
    }

    final data = BookingConfirmResponse.fromJson(jsonDecode(response.body));
    return data;
  }
}
