import 'package:url_launcher/url_launcher.dart';

class Helpers {
  static DateTime toUtcPlus8(DateTime dateTime) {
    // Normalize to UTC then convert to UTC+8 (e.g., Asia/Shanghai timezone offset)
    return dateTime.toUtc().add(const Duration(hours: 8));
  }

  static String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  static void openLink(String? href) {
    if (href != null) {
      launchUrl(Uri.parse(href));
    }
  }
}
