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
    // We use the Uri constructor to handle spaces and special characters safely
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'your-email@example.com', // Replace with your real email
      queryParameters: {
        'subject': 'Countify Support Request',
        'body': 'Hi, I need help with...',
      },
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
