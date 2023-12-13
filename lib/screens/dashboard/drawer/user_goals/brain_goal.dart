import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/scrollable_duration_picker.dart';

class BrainGoalScreen extends StatefulWidget {
  const BrainGoalScreen({Key? key}) : super(key: key);

  @override
  State<BrainGoalScreen> createState() => _BrainGoalScreenState();
}

class _BrainGoalScreenState extends State<BrainGoalScreen> {
  final Color pageColor = Colors.blue;
  int _selectedHour = 0;
  int _selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
        title: "Brain Activity Goal",
        appBarColor: pageColor,
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "My goal is",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(height: 18),
                  ScrollableDurationPicker(
                    selectedHour: _selectedHour,
                    selectedMinute: _selectedMinute,
                    minuteUpdate: (value) {
                      setState(() {
                        _selectedMinute = value;
                      });
                    },
                    hourUpdate: (value) {
                      setState(() {
                        _selectedHour = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  "SAVE",
                  style: TextStyles.smallTextBoldStyle(),
                ),
              ),
            )
          ],
        ));
  }
}
