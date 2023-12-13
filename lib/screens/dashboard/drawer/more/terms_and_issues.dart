import 'package:flutter/material.dart';
import 'package:wehealth/screens/dashboard/browser/global_browser.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

import '../../../../global/widgets/ios_close_appbar.dart';

class TermsAndServicesScreen extends StatefulWidget {
  const TermsAndServicesScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndServicesScreen> createState() => TermsAndServicesScreenState();
}

class TermsAndServicesScreenState extends State<TermsAndServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return const IosScaffoldWrapper(
      title: "Terms & Services",
      appBarColor: Colors.blue,
      body: GlobalBrowser(
        url: "https://umchtech.com/termsOfService.php",
      ),
    );
  }
}
