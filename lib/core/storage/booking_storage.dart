import 'dart:convert';
import 'dart:html';
import '../../models/export_models.dart';

class BookingStorage {
  static const _key = 'booking_history';

  static void save(List<ChatMessage> messages) {
    final jsonList = messages.map((m) => m.toJson()).toList();
    window.localStorage[_key] = jsonEncode(jsonList);
  }

  static List<ChatMessage> load() {
    final data = window.localStorage[_key];
    if (data == null) return [];

    final decoded = jsonDecode(data) as List;
    return decoded.map((e) => ChatMessage.fromJson(e)).toList();
  }

  static void clear() {
    window.localStorage.remove(_key);
  }
}
