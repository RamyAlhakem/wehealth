import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

class DietNutritionSettingsScreen extends StatefulWidget {
  const DietNutritionSettingsScreen({Key? key}) : super(key: key);

  @override
  State<DietNutritionSettingsScreen> createState() =>
      _DietNutritionSettingsScreenState();
}

class _DietNutritionSettingsScreenState
    extends State<DietNutritionSettingsScreen> {
  final pageColor = Colors.green.shade700;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Nutrient Settings",
      appBarColor: pageColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleDataSettingUnit(
              name: "Total Calories (EN)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Total Carbohydrate Intake (g)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Total Sugar Intake (g)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Total Protein Intake (g)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Total Fat Intake (g)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Saturated Fat (g)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Monounsaturated Fat (MUFA) (g)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Polyunsaturated Fat (PUFA) (g)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Trans Fat (g)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Cholesterol (mg)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Sodium (mg)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Calcium (mg)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Fibre (g)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Vitamin C (mg)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SingleDataSettingUnit(
              name: "Iron (mg)",
              currentData: "0",
              indicatorColor: pageColor,
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pageColor,
                  ),
                  onPressed: () {},
                  child: Text(
                    "SAVE",
                    style: TextStyles.smallTextBoldStyle(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleDataSettingUnit extends StatelessWidget {
  const SingleDataSettingUnit({
    Key? key,
    required this.name,
    required this.currentData,
    this.indicatorColor,
  }) : super(key: key);

  final String name;
  final String currentData;
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey.shade300,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    style: TextStyles.normalTextStyle(),
                  )),
            ),
          ),
          const Divider(
            height: 0,
            color: Colors.grey,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
              child: Center(
                child: TextField(
                  controller: TextEditingController(text: "0.0"),
                  cursorColor: indicatorColor,
                  style: TextStyles.normalTextStyle(),
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            height: 0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
