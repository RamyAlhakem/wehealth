import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/scrolling_date_picker.dart';

class ManualWaistCircumferenceWidget extends StatefulWidget {
  const ManualWaistCircumferenceWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ManualWaistCircumferenceWidget> createState() =>
      _ManualWaistCircumferenceWidgetState();
}

class _ManualWaistCircumferenceWidgetState
    extends State<ManualWaistCircumferenceWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final waistCircumCon = TextEditingController();
  final hipCircumCon = TextEditingController();
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
      /*  Get.showOverlay(
        loadingWidget: const OverlayLoadingIndicator(),
        asyncFunction: () async =>
            await Get.find<BloodOxygenController>().postUserBloodOxygenData(
          oxygenlevel: int.tryParse(waistCircumCon.text) ?? 0,
          pulseRate: int.tryParse(hipCircumCon.text) ?? 0,
          time: dayFormat.parse(recordTimeCon.text),
        ),
      ); */
    }
  }

  final pageColor = Colors.amber.shade700;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Waist-Hip Ratio",
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
                        controller: waistCircumCon,
                        inputType: TextInputType.number,
                        title: "Waist Circumference:",
                        validator: (value) {
                          final data = double.tryParse(value ?? '');
                          if (data == null) return 'Not a valid number.';
                          if (data < 10 || data > 400) {
                            return 'Waist Circumference must be between 10 and 400.';
                          }
                          return null;
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: hipCircumCon,
                        inputType: TextInputType.number,
                        title: "Hip Circumference:",
                        validator: (value) {
                          final data = double.tryParse(value ?? '');
                          if (data == null) return 'Not a valid number.';
                          if (data < 10 || data > 400) {
                            return ' Circumference must be between 10 and 400.';
                          }
                          return null;
                        },
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
                        validator: (value) {},
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
