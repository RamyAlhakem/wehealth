import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wehealth/screens/dashboard/drawer/more/about_us_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/more/contact_us_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/more/faq_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/more/privacy_policy_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/more/report_issue_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/more/terms_and_issues.dart';
import 'package:wehealth/screens/dashboard/drawer/more/user_manual/user_manual_screen.dart';
import '../../../../global/constants/app_constants.dart';
import '../../../../global/constants/images.dart';
import '../../../../global/styles/text_styles.dart';
import '../../../../http_cleint/app_config.dart';
import '../drawer_items.dart';
import 'utilities/utilities.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     drawer: const DrawerSide(),
      appBar: AppBar(
        title: Text(
          "More",
          style: TextStyles.textGreyBoldStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {},
              leading: Image.asset(Images.launcher),
              title: Platform.isIOS 
              ? Text('App Version :  ${AppConfig.iOSAppVersion}', 
                style: TextStyles.textGreyBoldStyle(),) 
              : Text('App Version :  ${AppConfig.androidAppVersion}',
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const AboutUsScreen());
              },
              leading: Image.asset(Images.aboutUs),
              title: Text(
                "About Us",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const ContactUsScreen());
              },
              leading: Image.asset(Images.contactUs),
              title: Text(
                "Contact Us",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const UserManualScreen());
              },
              leading: Image.asset(Images.usermanual),
              title: Text(
                "User Manual",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const FAQScreen());
              },
              leading: Image.asset(Images.questionaire),
              title: Text(
                "FAQ",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {
                if (Platform.isAndroid) {
                  const appId = 'connected.healthcare.checkupasia';
                  final url = Uri.parse("market://details?id=$appId");
                  launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                }else{
                const url = "https://apps.apple.com/my/app/wehealth/id1370251043";
                launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                
                }
              },
              leading: Image.asset(Images.rateapplication),
              title: Text(
                "Rate Application",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const ReportIssueScreen());
              },
              leading: Image.asset(Images.issuereporter),
              title: Text(
                "Report Issue",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const TermsAndServicesScreen());
              },
              leading: Image.asset(Images.termsofservice),
              title: Text(
                "Terms of Service",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const PrivacyPolicyScreen());
              },
              leading: Image.asset(Images.privacypolicy),
              title: Text(
                "Privacy Policy",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const UtilitiesScreen());
              },
              leading: Image.asset(Images.more),
              title: Text(
                "Utilities",
                style: TextStyles.normalTextBoldStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
