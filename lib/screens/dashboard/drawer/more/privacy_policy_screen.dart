import 'package:flutter/material.dart';
import 'package:wehealth/screens/dashboard/browser/global_browser.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

import '../../../../global/widgets/ios_close_appbar.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return const IosScaffoldWrapper(
      title: "Privacy Policy",
      appBarColor: Colors.blue,
      body: GlobalBrowser(
        url: "https://umchtech.com/privacyPolicy.php",
      ),
    );
  }
}
