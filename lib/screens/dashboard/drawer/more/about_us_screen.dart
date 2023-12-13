import 'package:flutter/material.dart';
import 'package:wehealth/global/constants/string.dart';
import '../../../../global/widgets/ios_close_appbar.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: 'About Us',
      //scaffoldBg: Colors.white,
      appBarColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Image.asset("assets/icons/launcher.png"),
                ),
              ),
            ),
            Divider(color: Colors.grey.shade800, thickness: 1),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
              child: Text(
                CustomStrings.aboutUs,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
