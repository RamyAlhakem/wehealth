import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';

class DietTimeSettingsScreen extends StatefulWidget {
  const DietTimeSettingsScreen({Key? key}) : super(key: key);

  @override
  State<DietTimeSettingsScreen> createState() => _DietTimeSettingsScreenState();
}

class _DietTimeSettingsScreenState extends State<DietTimeSettingsScreen> {
  final pageColor = Colors.green.shade700;
  String breakfastStart = "07.00 AM";
  String breakfastEnd = "08.00 AM";

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Time Settings",
      appBarColor: pageColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleSettingUnit(
              name: "Breakfast",
              startString: breakfastStart,
              endString: breakfastEnd,
              onChangeStart: (value) {
                setState(() {
                  breakfastStart = value;
                });
              },
              onChangeEnd: (value) {
                setState(() {
                  breakfastEnd = value;
                });
              },
            ),
            SingleSettingUnit(
              name: "Morning Tea",
              startString: breakfastStart,
              endString: breakfastEnd,
              onChangeStart: (value) {
                setState(() {
                  breakfastStart = value;
                });
              },
              onChangeEnd: (value) {
                setState(() {
                  breakfastEnd = value;
                });
              },
            ),
            SingleSettingUnit(
              name: "Lunch",
              startString: breakfastStart,
              endString: breakfastEnd,
              onChangeStart: (value) {
                setState(() {
                  breakfastStart = value;
                });
              },
              onChangeEnd: (value) {
                setState(() {
                  breakfastEnd = value;
                });
              },
            ),
            SingleSettingUnit(
              name: "Tea Break",
              startString: breakfastStart,
              endString: breakfastEnd,
              onChangeStart: (value) {
                setState(() {
                  breakfastStart = value;
                });
              },
              onChangeEnd: (value) {
                setState(() {
                  breakfastEnd = value;
                });
              },
            ),
            SingleSettingUnit(
              name: "Dinner",
              startString: breakfastStart,
              endString: breakfastEnd,
              onChangeStart: (value) {
                setState(() {
                  breakfastStart = value;
                });
              },
              onChangeEnd: (value) {
                setState(() {
                  breakfastEnd = value;
                });
              },
            ),
            SingleSettingUnit(
              name: "Supper",
              startString: breakfastStart,
              endString: breakfastEnd,
              onChangeStart: (value) {
                setState(() {
                  breakfastStart = value;
                });
              },
              onChangeEnd: (value) {
                setState(() {
                  breakfastEnd = value;
                });
              },
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

class SingleSettingUnit extends StatelessWidget {
  const SingleSettingUnit({
    Key? key,
    required this.name,
    required this.startString,
    required this.endString,
    required this.onChangeStart,
    required this.onChangeEnd,
  }) : super(key: key);

  final String name;
  final String startString;
  final String endString;
  final ValueChanged<String> onChangeStart;
  final ValueChanged<String> onChangeEnd;

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
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialEntryMode: TimePickerEntryMode.inputOnly,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                      );
                      if (time != null) onChangeStart(time.format(context));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(startString)),
                    ),
                  ),
                ),
                Text(
                  "-",
                  style: TextStyles.largeTextStyle(),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialEntryMode: TimePickerEntryMode.inputOnly,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                      );
                      if (time != null) onChangeEnd(time.format(context));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: FittedBox(
                          alignment: Alignment.centerRight,
                          child: Text(endString)),
                    ),
                  ),
                ),
              ],
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
