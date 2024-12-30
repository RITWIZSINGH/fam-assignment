// ignore_for_file: avoid_print

import 'package:url_launcher/url_launcher.dart';

class UrlService {
  static Future<void> openUrl(String? url) async {
    if (url == null) return;
    
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication, // or LaunchMode.inAppWebView
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
      throw 'Could not launch $url';
    }
  }
}