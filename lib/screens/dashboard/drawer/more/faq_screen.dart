import 'package:flutter/material.dart';
import 'package:wehealth/screens/dashboard/browser/global_browser.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

import '../../../../global/widgets/ios_close_appbar.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return const IosScaffoldWrapper(
      title: "F.A.Q",
      appBarColor: Colors.blue,
      body: GlobalBrowser(
        url: "https://www.ummc.edu.my/pesakit/FAQ.asp?kodBM=",
      ),
    );
  }
}
