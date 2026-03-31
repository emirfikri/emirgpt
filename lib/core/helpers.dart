import 'package:url_launcher/url_launcher.dart';

class Helpers {
  static String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  static void openLink(String? href) {
    if (href != null) {
      launchUrl(Uri.parse(href));
    }
  }
}
