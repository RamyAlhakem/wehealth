import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/body_temp_controller/body_temp_controller.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/add_doctor_appt.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';

import '../widgets/scrolling_date_picker.dart';

class ManualBodyTempWidget extends StatefulWidget {
  const ManualBodyTempWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ManualBodyTempWidget> createState() => _ManualBodyTempWidgetState();
}

class _ManualBodyTempWidgetState extends State<ManualBodyTempWidget> {
  String selectedType = "celsius (C)";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final tempLevelCon = TextEditingController();
  final recordTimeCon = TextEditingController();

  final notesCon = TextEditingController();

  final dayFormat = DateFormat("EEE, yyyy-MM-dd, h:mm a");
  final typesList = const ["celsius (C)", "fahrenheit (F)"];
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
            await Get.put(BodyTemperatureController()).postBodyTempData(
          tempLevel: double.parse(tempLevelCon.text),
          tempType: selectedType,
          time: dayFormat.parse(recordTimeCon.text),
        ),
      );
    }
  }

  final pageColor = Colors.amber.shade700;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Body Temperature Info",
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
                        controller: tempLevelCon,
                        inputType: TextInputType.number,
                        title: "Temperature Level:",
                        validator: (value) {
                          var data = double.tryParse(value!);
                          if (data == null) return "Invalid Number";
                          if (selectedType == typesList[0]) {
                            return (data < 20 || data > 45)
                                ? "Body Temperature must be between 20C and 45C"
                                : null;
                          } else {
                            return (data < 60 || data > 120)
                                ? "Body Temperature must be between 60F and 120F"
                                : null;
                          }
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTitledDropdown<String>(
                        title: "Unit",
                        selectedItem: selectedType,
                        options: typesList,
                        onChange: (value) {
                          setState(() {
                            selectedType = value!;
                          });
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
