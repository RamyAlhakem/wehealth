import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/heart_rate_controller/heart_rate_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/scrolling_date_picker.dart';
import 'package:wehealth/screens/dashboard/widgets/titled_radio.dart';

class ManualHeartRateWidget extends StatefulWidget {
  const ManualHeartRateWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ManualHeartRateWidget> createState() => _ManualHeartRateWidgetState();
}

class _ManualHeartRateWidgetState extends State<ManualHeartRateWidget> {
  final formKey = GlobalKey<FormState>();
  String selectedType = "Resting";
  final valueController = TextEditingController();
  final noteController = TextEditingController();
  final timeController = TextEditingController();
  final dayFormat = DateFormat("EEE, yyyy-MM-d, h:mm a");

  @override
  void initState() {
    super.initState();
    timeController.text = dayFormat.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Heart Rate Info",
      appBarColor: Colors.amber.shade600,
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  child: Column(
                    children: [
                      HorizontalTextFormField(
                        controller: valueController,
                        title: "Heart Rate Value:",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Type:",
                                style: TextStyles.smallTextBoldStyle(),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TitledRadioWidget<String>(
                                    title: "Resting",
                                    groupValue: selectedType,
                                    value: "Resting",
                                    onChange: (value) {
                                      setState(() {
                                        selectedType = value ?? "";
                                      });
                                    },
                                  ),
                                  TitledRadioWidget<String>(
                                    title: "Activity",
                                    groupValue: selectedType,
                                    value: "Activity",
                                    onChange: (value) {
                                      setState(() {
                                        selectedType = value ?? "";
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                              timeController.text = dayFormat.format(date);
                            });
                          }
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: HorizontalTextFormField(
                            controller: timeController,
                            title: "Record Time:",
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: noteController,
                        title: "Notes:",
                        maxLines: 3,
                      ),
                    ],
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
                onPressed: () async {
                  // print(selectedType);
                  if (formKey.currentState!.validate()) {
                    Get.showOverlay(
                      loadingWidget: const OverlayLoadingIndicator(),
                      asyncFunction: () async =>
                          Get.find<HeartRateController>().addUserHeartRate(
                        int.tryParse(valueController.text),
                        (selectedType == "Resting") ? 0 : 1,
                        dayFormat.parse(timeController.text),
                      ),
                    );
                  }
                },
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
      ),
    );
  }
}
