import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/models/data_model/medical_report_fetch_wrapper.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/scrolling_date_picker.dart';

import '../../../widgets/horizontal_titled_dropdown.dart';

class AddMedicalReportScreen extends StatefulWidget {
  const AddMedicalReportScreen({Key? key, this.medicalReport})
      : super(key: key);
  final MedicalReportData? medicalReport;

  @override
  State<AddMedicalReportScreen> createState() => _AddMedicalReportScreenState();
}

class _AddMedicalReportScreenState extends State<AddMedicalReportScreen> {
  MedicalReportData? updateData;

  String selectedType = "Radiology";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameCon = TextEditingController();
  final recordTimeCon = TextEditingController();
  File? file;
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

    if (widget.medicalReport != null) {
      updateData = widget.medicalReport;
      nameCon.text = updateData!.reportname ?? "";
      recordTimeCon.text = dayFormat.format(updateData!.date);
      if (updateData!.reportTypeDecoded == "Lab") typesList.add("Lab");
      selectedType = updateData!.reportTypeDecoded;
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

  final baseColor = Colors.deepPurpleAccent;
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Medical Report",
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
                      HorizontalTitledDropdown<String>(
                        title: "Report Type",
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
                      HorizontalTextFormField(
                        controller: nameCon,
                        title: "Report Name",
                        validator: (value) {},
                      ),
                      const SizedBox(height: 18),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            Text(
                              "Upload Medical Report",
                              style: TextStyles.smallTextBoldStyle(),
                            ),
                            const SizedBox(width: 24),
                            IconButton(
                              iconSize: 32,
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.file_present_rounded),
                              onPressed: () async {
                                print("Check!");
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
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
                              icon: const Icon(Icons.picture_as_pdf_rounded),
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
