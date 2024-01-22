// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/blood_pressure_controller/blood_pressure_controller.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/ble/Helper.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import '../widgets/scrolling_date_picker.dart';
import 'package:dio/dio.dart';

class ManualBloodPressureWidget extends StatefulWidget {
  final int? sys;
  final int? dia;
  final int? pul;
  const ManualBloodPressureWidget({Key? key, this.sys, this.dia, this.pul})
      : super(key: key);

  @override
  State<ManualBloodPressureWidget> createState() =>
      _ManualBloodPressureWidgetState();
}

class _ManualBloodPressureWidgetState extends State<ManualBloodPressureWidget> {
  String selectedType = "Resting";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final systolicCon = TextEditingController();
  final diastolicCon = TextEditingController();
  final pulseCon = TextEditingController();
  final recordTimeCon = TextEditingController();

  final notesCon = TextEditingController();

  final dayFormat = DateFormat("EEE yyyy-MM-dd k:mm");

  @override
  void initState() {
    super.initState();
    recordTimeCon.text = dayFormat.format(DateTime.now());
    systolicCon.text = widget.sys.toString();
    diastolicCon.text = widget.dia.toString();
    pulseCon.text = widget.pul.toString();
  }

  bpDataValidateFunction() async {
    if (_formKey.currentState!.validate()) {
      print("Validated!");
      Get.showOverlay(
        loadingWidget: const OverlayLoadingIndicator(),
        asyncFunction: () async =>
            await Get.put(BloodPressureController()).addBpData(
          context: context,
          systolic: int.parse(systolicCon.text),
          diastolic: int.parse(diastolicCon.text),
          pulse: int.parse(pulseCon.text),
          recordTime: dayFormat.parse(recordTimeCon.text),
          notes: notesCon.text,
        ),
      );
    }
  }

  final pageColor = Colors.orange.shade700;
  Dio dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return DrawerNotificationScaffold(
      title: "Blood Pressure",
      baseColor: pageColor,
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
                        controller: systolicCon,
                        inputType: TextInputType.number,
                        title: "Systolic:",
                        titleColor: Colors.orange.shade700,
                        inputDecoration: InputDecoration(
                          fillColor: Colors.orange.shade700,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.orange.shade700,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.orange.shade700),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      HorizontalTextFormField(
                        controller: diastolicCon,
                        inputType: TextInputType.number,
                        title: "Diastolic:",
                        titleColor: Colors.orange.shade700,
                        inputDecoration: InputDecoration(
                          fillColor: Colors.orange.shade700,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.orange.shade700,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.orange.shade700),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      HorizontalTextFormField(
                        controller: pulseCon,
                        inputType: TextInputType.number,
                        title: "Pulse:",
                        titleColor: Colors.orange.shade700,
                        inputDecoration: InputDecoration(
                          fillColor: Colors.orange.shade700,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.orange.shade700,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.orange.shade700),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
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
                            titleColor: Colors.orange.shade700,
                            inputDecoration: InputDecoration(
                              fillColor: Colors.orange.shade700,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.orange.shade700,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: Colors.orange.shade700),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      HorizontalTextFormField(
                        controller: notesCon,
                        title: "Notes:",
                        titleColor: Colors.orange.shade700,
                        maxLines: 3,
                        validator: (value) {
                          return null;
                        },
                        inputDecoration: InputDecoration(
                          fillColor: Colors.orange.shade700,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.orange.shade700,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.5, color: Colors.orange.shade700),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
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
                  color: Colors.orange.shade600,
                ),
                // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                foregroundColor: Colors.amber.shade600,
              ),
              onPressed: bpDataValidateFunction,
              child: Text(
                "SAVE",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.orange.shade700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
