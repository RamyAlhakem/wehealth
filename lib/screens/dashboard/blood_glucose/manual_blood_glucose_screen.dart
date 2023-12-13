// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/blood_glucose_controller/blood_glucose_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import '../widgets/scrolling_date_picker.dart';

class ManualBloodGlucoseWidget extends StatefulWidget {
  const ManualBloodGlucoseWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ManualBloodGlucoseWidget> createState() =>
      _ManualBloodGlucoseWidgetState();
}

class _ManualBloodGlucoseWidgetState extends State<ManualBloodGlucoseWidget> {
  String selectedType = "BeforeMeal";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final glucoseLevelCon = TextEditingController();
  final recordTimeCon = TextEditingController();
  final notesCon = TextEditingController();
  final baseColor = Colors.grey;
  final dayFormat = DateFormat("EEE yyyy-MM-d k:mm");

  @override
  void initState() {
    super.initState();
    recordTimeCon.text = dayFormat.format(DateTime.now());
  }

  submitFunctionFunction() async {
    if (_formKey.currentState!.validate()) {
      print("Validated!");
      Get.showOverlay(
        loadingWidget: const OverlayLoadingIndicator(),
        asyncFunction: () =>
            Get.find<BloodGlucoseController>().postUserBloodGlucoseData(
          glucoseLevel: double.tryParse(glucoseLevelCon.text)!,
          mealType: selectedType,
          time: dayFormat.parse(recordTimeCon.text),
          note: notesCon.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Blood Glucose",
      appBarColor: baseColor,
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
                        controller: glucoseLevelCon,
                        inputType: TextInputType.number,
                        title: "Glucose Level:",
                        validator: (value) {
                          double? number = double.tryParse(value ?? "");
                          return (number != null && number >= 1 && number <= 28)
                              ? null
                              : "Glucose Level Must be Between 1 mmol/L and 28 mmol/L";
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
                        validator: (value) => null,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 40,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Meal Type:",
                            style: TextStyles.extraSmallText14BStyle(),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 16 / 5,
                        children: [
                          MealTypeOptionWidget(
                            currentId: selectedType,
                            id: "BeforeMeal",
                            imagePath: "assets/images/lunchicon.webp",
                            name: "Before Meal",
                            onClick: (id) {
                              setState(() {
                                selectedType = id;
                              });
                            },
                          ),
                          MealTypeOptionWidget(
                            currentId: selectedType,
                            id: "AfterMeal",
                            imagePath: "assets/images/dinner.webp",
                            name: "After Meal",
                            onClick: (id) {
                              setState(() {
                                selectedType = id;
                              });
                            },
                          ),
                          MealTypeOptionWidget(
                            currentId: selectedType,
                            id: "Fasting",
                            imagePath: "assets/images/lunchicon.webp",
                            name: "Fasting",
                            onClick: (id) {
                              setState(() {
                                selectedType = id;
                              });
                            },
                          ),
                          MealTypeOptionWidget(
                            currentId: selectedType,
                            id: "BeforeBed",
                            imagePath: "assets/images/dinner.webp",
                            name: "Before Bed",
                            onClick: (id) {
                              setState(() {
                                selectedType = id;
                              });
                            },
                          ),
                          MealTypeOptionWidget(
                            currentId: selectedType,
                            id: "Other",
                            imagePath: "assets/images/other.png",
                            name: "Other",
                            onClick: (id) {
                              setState(() {
                                selectedType = id;
                              });
                            },
                          ),
                        ],
                      )
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
                  color: baseColor,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                //foregroundColor: baseColor,
              ),
              onPressed: submitFunctionFunction,
              child: const Text(
                "SAVE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MealTypeOptionWidget extends StatelessWidget {
  const MealTypeOptionWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.currentId,
    required this.imagePath,
    required this.onClick,
  }) : super(key: key);

  final String id;
  final String name;
  final String currentId;
  final String imagePath;
  final ValueChanged<String> onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(id),
      child: Container(
        decoration: BoxDecoration(
          color: currentId == id ? Colors.deepPurple : null,
          border: Border.all(
            color: Colors.grey.shade700,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                imagePath,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 6,
              child: Text(
                name,
                style: TextStyles.extraSmallText12BStyle().copyWith(
                  color: currentId == id ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
