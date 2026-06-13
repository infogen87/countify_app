import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static const String _privacyPolicyUrl =
      'https://sites.google.com/view/countifyprivacypolicy';
  static final InAppReview _inAppReview = InAppReview.instance;

  static Future<void> launchPrivacyPolicy() async {
    final Uri url = Uri.parse(_privacyPolicyUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_privacyPolicyUrl';
    }
  }

  static Future<void> launchSupportEmail() async {
    final subject = Uri.encodeComponent('Countify Support Request');
    final body = Uri.encodeComponent('Hi, I need help with...');

    final Uri emailLaunchUri = Uri.parse(
      'mailto:uzevie1234@gmail.com?subject=$subject&body=$body',
    );

    if (!await launchUrl(emailLaunchUri)) {
      // If this fails on Web, it's usually because no default mail app is set
      // print('Could not launch email client');
    }
  }

  static Future<void> requestInAppReview() async {
    // This is the "Pop-up" version for milestones
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
    }
  }

  static Future<void> openPlayStoreForAppReview() async {
    // This is for the button in your Settings Page
    // Note: On Android, it uses the package name from your build.gradle
    await _inAppReview.openStoreListing();
  }
}
