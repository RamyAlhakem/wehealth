import 'package:flutter/material.dart';
import 'package:wehealth/global/constants/string.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

import '../../../../global/widgets/ios_close_appbar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: 'Contact Us',
      //scaffoldBg: Colors.white,
      appBarColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                CustomStrings.contactUs,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              height: 200,
              width: double.infinity,
              child: ColoredBox(
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 3),
            const Divider(color: Colors.grey, thickness: 5),
            // const SizedBox(height: 3),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(
                children: const [
                  Text(
                    "Current Version:  ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("2.4"),
                  Spacer(),
                  Text(
                    "Released Date:  ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("4th Jan 2017"),
                ],
              ),
            ),
            const SizedBox(height: 8),
            BorderedRow(
              items: [
                SizedBox.square(
                  child: Image.asset('assets/icons/whatsappicon.webp'),
                ),
                const SizedBox(width: 12),
                SizedBox.square(
                  child: Image.asset('assets/icons/whatsappicon.webp'),
                ),
                const SizedBox(width: 12),
                SizedBox.square(
                  child: Image.asset('assets/icons/whatsappicon.webp'),
                ),
                const SizedBox(width: 12),
                SizedBox.square(
                  child: Image.asset('assets/icons/googleplusicon.webp'),
                ),
                const SizedBox(width: 12),
                Text(
                  "CHIEF.UMCH",
                  style: TextStyles.extraLargeTextStyle(),
                ),
              ],
            ),
            BorderedRow(
              items: [
                SizedBox.square(
                  child: Image.asset('assets/icons/twittericon.webp'),
                ),
                const SizedBox(width: 12),
                SizedBox.square(
                  child: Image.asset('assets/icons/twittericon.webp'),
                ),
                const SizedBox(width: 12),
                Text(
                  "CHIEF_UMCH",
                  style: TextStyles.extraLargeTextStyle(),
                ),
              ],
            ),
            BorderedRow(
              items: [
                SizedBox.square(
                  child: Image.asset('assets/icons/whatsappicon.webp'),
                ),
                const SizedBox(width: 12),
                SizedBox.square(
                  child: Image.asset('assets/icons/twittericon.webp'),
                ),
                const SizedBox(width: 12),
                Text(
                  "+601182181328",
                  style: TextStyles.extraLargeTextStyle(),
                ),
              ],
            ),
            BorderedRow(
              items: [
                SizedBox.square(
                  child: Image.asset('assets/icons/whatsappicon.webp'),
                ),
                const SizedBox(width: 12),
                Text(
                  "lifestyle@umchtech.com",
                  style: TextStyles.extraLargeTextStyle(),
                ),
              ],
            ),
            BorderedRow(
              items: [
                SizedBox.square(
                  child: Image.asset('assets/icons/whatsappicon.webp'),
                ),
                const SizedBox(width: 12),
                Text(
                  "www.umchtech.com",
                  style: TextStyles.extraLargeTextStyle(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "A joint Research And Development Project By",
                style: TextStyles.smallTextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Exclusively Deistributed By",
                style: TextStyles.smallTextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BorderedRow extends StatelessWidget {
  const BorderedRow({
    Key? key,
    required this.items,
  }) : super(key: key);
  final List<Widget> items;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(color: Colors.grey, width: 0.5))),
      child: Row(
        children: items,
      ),
    );
  }
}
