import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/blood_oxygen_controller/blood_oxygen_controller.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';

import '../widgets/scrolling_date_picker.dart';

class ManualBloodOxygenWidget extends StatefulWidget {
  const ManualBloodOxygenWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ManualBloodOxygenWidget> createState() =>
      _ManualBloodOxygenWidgetState();
}

class _ManualBloodOxygenWidgetState extends State<ManualBloodOxygenWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final oxygenLevelCon = TextEditingController();
  final pulseRateCon = TextEditingController();
  final recordTimeCon = TextEditingController();
  final notesCon = TextEditingController();

  final dayFormat = DateFormat("EEE, yyyy-MM-dd, h:mm a");
  @override
  void initState() {
    super.initState();
    recordTimeCon.text = dayFormat.format(DateTime.now());
  }

  bodyTempValidateFunction() async {
    if (_formKey.currentState!.validate()) {
      print("Validated!");
      Get.showOverlay(
        loadingWidget: const OverlayLoadingIndicator(),
        asyncFunction: () async =>
            await Get.find<BloodOxygenController>().postUserBloodOxygenData(
          oxygenlevel: int.tryParse(oxygenLevelCon.text) ?? 0,
          pulseRate: int.tryParse(pulseRateCon.text) ?? 0,
          time: dayFormat.parse(recordTimeCon.text),
        ),
      );
    }
  }

  final pageColor = Colors.amber.shade700;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Blood Oxygen Info",
      appBarColor: pageColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              child: Form(
                key: _formKey,
                   child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HorizontalTextFormField(
                        controller: oxygenLevelCon,
                        inputType: TextInputType.number,
                        title: "Oxygen Level:",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: pulseRateCon,
                        inputType: TextInputType.number,
                        title: "Pulse Rate:",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: () async {
                          DateTime? date =
                              await showBoxyScrollingPicker(context);
                          log(date.toString());
                          if (date != null) {
                            log("Selected Date ${date.toString()}");
                            setState(() {
                              recordTimeCon.text = dayFormat.format(date);
                            });
                          }
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: HorizontalTextFormField(
                            controller: recordTimeCon,
                            title: "Record Time:",
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: notesCon,
                        title: "Notes:",
                        maxLines: 3,
                        validator: (value) {
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Colors.amber.shade600,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                foregroundColor: Colors.amber.shade600,
              ),
              onPressed: bodyTempValidateFunction,
              child: const Text(
                "SAVE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
