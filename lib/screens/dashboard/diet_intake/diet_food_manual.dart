import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';

class DietFoodManualScreen extends StatefulWidget {
  const DietFoodManualScreen({Key? key}) : super(key: key);

  @override
  State<DietFoodManualScreen> createState() => _DietFoodManualScreenState();
}

class _DietFoodManualScreenState extends State<DietFoodManualScreen> {
  final pageColor = Colors.green.shade700;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
    title: "",
    appBarColor: pageColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  "Diet CAM",
                  style: TextStyles.extraLargeTextStyle(),
                ),
              ),
            ),
            Image.asset("assets/icons/dietcamintro.webp"),
            Expanded(
              child: FittedBox(
                child: Icon(
                  Icons.videocam_rounded,
                  color: pageColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
