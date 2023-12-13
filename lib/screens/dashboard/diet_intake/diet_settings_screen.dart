import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/diet_intake/diet_add_class.dart';
import 'package:wehealth/screens/dashboard/diet_intake/diet_notification_class_settings.dart';
import 'package:wehealth/screens/dashboard/diet_intake/diet_nutrition_settings_screen.dart';
import 'package:wehealth/screens/dashboard/diet_intake/diet_time_settings_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

class DietSettingsScreen extends StatefulWidget {
  const DietSettingsScreen({Key? key}) : super(key: key);

  @override
  State<DietSettingsScreen> createState() => _DietSettingsScreenState();
}

class _DietSettingsScreenState extends State<DietSettingsScreen> {
  final pageColor = Colors.green.shade700;
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      appBarColor: pageColor,
      title: "Diet Settings",
      body: SizedBox.expand(
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: pageColor,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const DietTimeSettingsScreen());
              },
              leading: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  "assets/icons/timesettings.webp",
                  color: pageColor,
                ),
              ),
              title: Text(
                "Time Settings",
                style: TextStyles.smallTextStyle().copyWith(color: pageColor),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: pageColor,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const DietNutritionSettingsScreen());
              },
              leading: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  "assets/icons/nutritionistsetting.png",
                  color: pageColor,
                ),
              ),
              title: Text(
                "Nutrition Settings",
                style: TextStyles.smallTextStyle().copyWith(color: pageColor),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: pageColor,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const DietNotificationClassSettingScreen());
              },
              leading: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  "assets/icons/nutritionisticon.webp",
                  color: pageColor,
                ),
              ),
              title: Text(
                "NotificationClass Settings",
                style: TextStyles.smallTextStyle().copyWith(color: pageColor),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: pageColor,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const DietAddClassScreen());
              },
              leading: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  "assets/icons/food_breakfast.webp",
                  color: pageColor,
                ),
              ),
              title: Text(
                "Add Class",
                style: TextStyles.smallTextStyle().copyWith(color: pageColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
