// filepath: lib/utils/launcher.dart
import 'package:url_launcher/url_launcher.dart';

Future<void> launchWebsite(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Tidak dapat membuka $url';
  }
}