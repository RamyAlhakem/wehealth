import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_wrapper.dart';

class HeartGoalScreen extends StatefulWidget {
  const HeartGoalScreen({Key? key}) : super(key: key);

  @override
  State<HeartGoalScreen> createState() => _HeartGoalScreenState();
}

class _HeartGoalScreenState extends State<HeartGoalScreen> {
  final Color pageColor = Colors.blue.shade300;
  double _min = 50;
  double _max = 80;
  bool _notify = false;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Heart Rate Goal",
      appBarColor: pageColor,
      body: SizedBox.expand(
        child: Column(
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
                  Text(
                    "2000 ml/day",
                    style: TextStyles.extraLargeTextBoldStyle().copyWith(
                      color: pageColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text("Min"),
                        Expanded(
                          child: RangeSlider(
                            min: 20,
                            max: 160,
                            divisions: 140,
                            values: RangeValues(_min, _max),
                            labels:
                                RangeLabels("${_min.ceil()}", "${_max.ceil()}"),
                            onChanged: (value) {
                              log("Changing!");
                              setState(() {
                                _min = value.start;
                                _max = value.end;
                              });
                            },
                          ),
                        ),
                        Text("Max"),
                      ],
                    ),
                  ),
                  SwitchListTile(
                    value: _notify,
                    title: Text(
                      "Enable Notification",
                      style: TextStyle(
                        color: pageColor,
                        fontSize: 18,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _notify = value;
                      });
                    },
                  ),
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
        ),
      ),
    );
  }
}
