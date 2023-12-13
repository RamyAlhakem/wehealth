import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_wrapper.dart';

class BloodPressureGoalScreen extends StatefulWidget {
  const BloodPressureGoalScreen({Key? key}) : super(key: key);

  @override
  State<BloodPressureGoalScreen> createState() =>
      _BloodPressureGoalScreenState();
}

class _BloodPressureGoalScreenState extends State<BloodPressureGoalScreen> {
  final Color pageColor = Colors.blue.shade300;
  double _minDia = 100;
  double _minSis = 100;
  double _maxDia = 120;
  double _maxSis = 120;
  bool _notify = false;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Blood Pressure Goal",
      appBarColor: pageColor,
      body: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Your goal for blood pressure are",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Systolic",
                          style: TextStyles.smallTextStyle(),
                        ),
                        Text(
                          "${_minSis.ceil()}-${_maxSis.ceil()} mmHg",
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
                            min: 80,
                            max: 250,
                            divisions: 170,
                            values: RangeValues(_minSis, _maxSis),
                            labels: RangeLabels(
                                "${_minSis.ceil()}", "${_maxSis.ceil()}"),
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
                          "Diastolic",
                          style: TextStyles.smallTextStyle(),
                        ),
                        Text(
                          "${_minDia.ceil()}-${_maxDia.ceil()} mmHg",
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
                            min: 50,
                            max: 180,
                            divisions: 130,
                            values: RangeValues(_minDia, _maxDia),
                            labels: RangeLabels(
                                "${_minDia.ceil()}", "${_maxDia.ceil()}"),
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
