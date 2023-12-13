import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/scrolling_date_picker.dart';

class ManualBodyWeightWidget extends StatefulWidget {

  const ManualBodyWeightWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ManualBodyWeightWidget> createState() => _ManualBodyWeightWidgetState();
}

class _ManualBodyWeightWidgetState extends State<ManualBodyWeightWidget> {
  final formKey = GlobalKey<FormState>();

  final valueController = TextEditingController();
  final noteController = TextEditingController();
  final timeController = TextEditingController();
  final dayFormat = DateFormat("EEE yyyy-MM-dd HH:mm");

  @override
  void initState() {
    super.initState();
    timeController.text = dayFormat.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return IosScaffoldWrapper(
          title: "Body Weight",
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
                            title: "Weight:",
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
                          Divider(
                            thickness: 1,
                            color: Colors.grey.shade300,
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
                      if (formKey.currentState!.validate()) {                   
                        Get.showOverlay(
                          loadingWidget: const OverlayLoadingIndicator(),
                          asyncFunction: () async =>
                            Get.find<BodyMeasurementController>().addUserBodyWeight(
                            weightQty: double.parse(valueController.text),                  
                            height: double.parse(profileController.userProfile.height!),
                            time: dayFormat.parse(timeController.text),
                            note: noteController.text,
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
    );
  }
}
