import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_wrapper.dart';

class BloodGlucoseGoalScreen extends StatefulWidget {
  const BloodGlucoseGoalScreen({Key? key}) : super(key: key);

  @override
  State<BloodGlucoseGoalScreen> createState() => _BloodGlucoseGoalScreenState();
}

class _BloodGlucoseGoalScreenState extends State<BloodGlucoseGoalScreen> {
  final Color pageColor = Colors.blue.shade300;
  double _minDia = 2;
  double _minSis = 2;
  double _maxDia = 3;
  double _maxSis = 3;
  bool _notify = false;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Blood Glucose Goal",
      appBarColor: pageColor,
      body: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Your goal for blood glucose are",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Before Meal",
                          style: TextStyles.smallTextStyle(),
                        ),
                        Text(
                          "${_minSis.toStringAsFixed(2)}-${_maxSis.toStringAsFixed(2)} mmHg",
                          style: TextStyles.normalTextStyle().copyWith(
                            color: pageColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text("Min"),
                        Expanded(
                          child: RangeSlider(
                            min: 0,
                            max: 15,
                            divisions: 1500,
                            values: RangeValues(_minSis, _maxSis),
                            labels: RangeLabels(_minSis.toStringAsFixed(2),
                                _maxSis.toStringAsFixed(2)),
                            onChanged: (value) {
                              log("Changing!");
                              setState(() {
                                _minSis = value.start;
                                _maxSis = value.end;
                              });
                            },
                          ),
                        ),
                        Text("Max"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "After Meal",
                          style: TextStyles.smallTextStyle(),
                        ),
                        Text(
                          "${_minDia.toStringAsFixed(2)}-${_maxDia.toStringAsFixed(2)} mmHg",
                          style: TextStyles.normalTextStyle().copyWith(
                            color: pageColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text("Min"),
                        Expanded(
                          child: RangeSlider(
                            min: 0,
                            max: 15,
                            divisions: 1500,
                            values: RangeValues(_minDia, _maxDia),
                            labels: RangeLabels(_minDia.toStringAsFixed(2),
                                _maxDia.toStringAsFixed(2)),
                            onChanged: (value) {
                              log("Changing!");
                              setState(() {
                                _minDia = value.start;
                                _maxDia = value.end;
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
