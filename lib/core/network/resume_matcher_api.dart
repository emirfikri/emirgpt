import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ResumeMatcherApi {
  // final String baseUrl;

  ResumeMatcherApi();
  static const baseUrl = 'https://emirgpt-backend.vercel.app';

  Future<String> match({
    required String resume,
    required String jobDescription,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/ai/profile-fit'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'resume': resume, 'jobDescription': jobDescription}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to match resume');
    }

    final json = jsonDecode(response.body);
    debugPrint('response: $json');
    return json['reply'];
  }
}
