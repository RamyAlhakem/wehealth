import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
    title: "Fitness Assesment",
    appBarColor: Colors.blue,
     
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            ListTile(
              onTap: () {},
              title: Center(
                child: Text(
                  "Target Challenges",
                  style: TextStyles.smallTextStyle(),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              title: Center(
                child: Text(
                  "Team Challenges",
                  style: TextStyles.smallTextStyle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
