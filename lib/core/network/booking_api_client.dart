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
    return BookingAiReplyRaw.fromJson(data);
  }
}
