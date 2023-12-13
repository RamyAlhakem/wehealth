import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/models/data_model/lab_report_fetch_wrapper.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/scrolling_date_picker.dart';

class AddLabReportScreen extends StatefulWidget {
  const AddLabReportScreen({Key? key, this.reportData}) : super(key: key);
  final LabReportData? reportData;
  @override
  State<AddLabReportScreen> createState() => _AddLabReportScreenState();
}

class _AddLabReportScreenState extends State<AddLabReportScreen> {
  LabReportData? updateData;
  final baseColor = Colors.deepPurpleAccent;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameCon = TextEditingController();
  final totalColCon = TextEditingController();
  final hdlCon = TextEditingController();
  final colestersolCon = TextEditingController();
  final ldlCon = TextEditingController();
  final triGlecierCon = TextEditingController();
  final fastingPlasmaCon = TextEditingController();
  final hemoglobinCon = TextEditingController();
  final recordTimeCon = TextEditingController();
  File? file;
  String selectedType = "Radiology";
  final dayFormat = DateFormat("EEE, yyyy-MM-d, h:mm a");
  final typesList = const [
    "Radiology",
    "Wellness",
    "Discharge Summary",
    "Other Report",
  ];

  @override
  void initState() {
    super.initState();
    if (widget.reportData != null) {
      updateData = widget.reportData;
      recordTimeCon.text = dayFormat.format(updateData!.date);
      nameCon.text = updateData!.reportname ?? "";
      totalColCon.text = updateData!.totalcholestrol.toString();
      hdlCon.text = updateData!.totalhdl.toString();
      colestersolCon.text = updateData!.cholestrolhdlratio.toString();
      ldlCon.text = updateData!.totalldl.toString();
      triGlecierCon.text = updateData!.totaltriglycerides.toString();
      fastingPlasmaCon.text = updateData!.totalplasmaglucose.toString();
      hemoglobinCon.text = updateData!.hemoglobin.toString();
    } else {
      recordTimeCon.text = dayFormat.format(DateTime.now());
    }
  }

  submitFunction() async {
    if (_formKey.currentState!.validate()) {
      // print("Validated!");
      /*  Get.showOverlay(
        loadingWidget: const OverlayLoadingIndicator(),
        asyncFunction: () async =>
            await Get.put(BodyTemperatureController()).postBodyTempData(
          tempLevel: double.parse(tempLevelCon.text),
          tempType: selectedType,
          time: dayFormat.parse(recordTimeCon.text),
        ),
      ); */
    }
  }

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Lab Report",
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
                            title: "Record Date",
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: nameCon,
                        title: "Report Name",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: totalColCon,
                        inputType: TextInputType.number,
                        title: "Total Cholesterol(mmol/L)",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: hdlCon,
                        inputType: TextInputType.number,
                        title: "HDL(mmol/L)",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: colestersolCon,
                        inputType: TextInputType.number,
                        title: "Cholestrol/HDL Ratio(mmol/L)",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: ldlCon,
                        inputType: TextInputType.number,
                        title: "LDL(mmol/L)",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: triGlecierCon,
                        inputType: TextInputType.number,
                        title: "Triglycerides(mmol/L)",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: fastingPlasmaCon,
                        inputType: TextInputType.number,
                        title: "Fasting Plasma Glucose(mmol/L)",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      HorizontalTextFormField(
                        controller: hemoglobinCon,
                        inputType: TextInputType.number,
                        title: "Hemoglobin A1c(%)",
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "Upload Medical Report",
                            style: TextStyles.smallTextBoldStyle(),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  iconSize: 32,
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.file_present_rounded),
                                  onPressed: () async {
                                    print("Check!");
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                      // TODO: NEED to allow only image and pdf!
                                      // allowedExtensions: ['pdf', 'doc'],
                                    );
                                    if (result != null) {
                                      setState(() {
                                        file = File(result.files.single.path!);
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  iconSize: 32,
                                  padding: EdgeInsets.zero,
                                  icon:
                                      const Icon(Icons.picture_as_pdf_rounded),
                                  onPressed: () async {
                                    print("Check!");
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf', 'doc'],
                                    );
                                    if (result != null) {
                                      setState(() {
                                        file = File(result.files.single.path!);
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  iconSize: 32,
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.camera_alt_rounded),
                                  onPressed: () async {
                                    XFile? res = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    if (res != null) {
                                      setState(() {
                                        file = File(res.path);
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
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
                side: const BorderSide(
                  color: Colors.deepPurpleAccent,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                foregroundColor: Colors.deepPurpleAccent,
              ),
              onPressed: submitFunction,
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
