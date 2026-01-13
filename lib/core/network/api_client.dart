import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const _baseUrl = 'https://emirgpt-backend.vercel.app/api/ai';

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );
    debugPrint('response: ${jsonDecode(response.body)}');
    if (response.statusCode != 200) {
      throw Exception('Failed to get AI response');
    }

    final data = jsonDecode(response.body);
    return data['reply'];
  }
}
