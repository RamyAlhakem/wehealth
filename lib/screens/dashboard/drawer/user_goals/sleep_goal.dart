import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/scrollable_duration_picker.dart';

class SleepGoalScreen extends StatefulWidget {
  const SleepGoalScreen({Key? key}) : super(key: key);

  @override
  State<SleepGoalScreen> createState() => _SleepGoalScreenState();
}

class _SleepGoalScreenState extends State<SleepGoalScreen> {
  final Color pageColor = Colors.blue;
  int _selectedHour = 0;
  int _selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
        title: "Sleep Goal",
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
                  const SizedBox(height: 18),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    width: double.infinity,
                    height: 200,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: CurrentSleepDataRow(
                            title: "Week Days",
                            sleepString: "09:00 PM",
                            wakeUpString: "06:00 AM",
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 0,
                        ),
                        Expanded(
                          child: CurrentSleepDataRow(
                            title: "Weekend",
                            sleepString: "09:00 PM",
                            wakeUpString: "06:00 AM",
                          ),
                        ),
                      ],
                    ),
                  )
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

class CurrentSleepDataRow extends StatelessWidget {
  const CurrentSleepDataRow({
    Key? key,
    required this.title,
    required this.wakeUpString,
    required this.sleepString,
  }) : super(key: key);

  final String title;
  final String wakeUpString;
  final String sleepString;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: FittedBox(child: Icon(Icons.timer)),
                ),
              ),
              const Divider(color: Colors.grey, thickness: 1, height: 0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(sleepString),
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
          width: 0,
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FittedBox(
              child: Text(
                title,
              ),
            ),
          ),
        ),
        const VerticalDivider(
          color: Colors.grey,
          thickness: 1,
          width: 0,
        ),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: FittedBox(child: Icon(Icons.timer)),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(wakeUpString),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
