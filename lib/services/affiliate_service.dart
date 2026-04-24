import 'package:url_launcher/url_launcher.dart';

class AffiliateService {

  static final Uri playabetsUrl =
      Uri.parse('https://playabets.click/o/5_pu2p');

  static Future<void> openPlayabets() async {

    if (await canLaunchUrl(playabetsUrl)) {
      await launchUrl(
        playabetsUrl,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}