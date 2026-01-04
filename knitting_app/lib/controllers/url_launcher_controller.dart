// Video yükleniyor animasyonu

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> openYoutubeVideo(String videoId) async {
  final Uri appUrl = Uri.parse('vnd.youtube:$videoId');
  final Uri webUrl = Uri.parse('https://www.youtube.com/watch?v=$videoId');

  if (await canLaunchUrl(appUrl)) {
    await launchUrl(appUrl);
  } else {
    await launchUrl(webUrl, mode: LaunchMode.externalApplication);
  }
}

Future<void> openWhatsAppSupport({required String message}) async {
  final phone = dotenv.env['SUPPORT_WHATSAPP_NUMBER'];
  if (phone == null || phone.isEmpty) {
    throw Exception('SUPPORT_WHATSAPP_NUMBER .env içinde yok!');
  }
  final uri = Uri.parse(
    'https://wa.me/$phone?text=${Uri.encodeComponent(message)}',
  );

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Whatsapp acilamadi!');
  }
}
