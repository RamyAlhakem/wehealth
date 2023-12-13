import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_controller.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import '../../../models/data_model/user_medicine_data_wrapper.dart';
import '../drawer/home/appointment/appt_constants.dart';
import 'med_assist_constants.dart';
import 'reason_for_skip_screen.dart';

class TakenOrSkip extends StatefulWidget {
  final UserMedicineData medicineDetails;
  const TakenOrSkip({super.key, required this.medicineDetails});

  @override
  State<TakenOrSkip> createState() => _TakenOrSkipState();
}

class _TakenOrSkipState extends State<TakenOrSkip> {
  int radioSkip = 0;
  int? skippedValue;
  
  int radioTaken = 1;
  int? takenValue;

  @override
  void initState() {
    super.initState();
    Get.find<MedAssistController>().fetchMedicineStatusData();
    
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedAssistController>(
      builder: (medAssistController) {
        return IosScaffoldWrapper(
          title: "Med Assist",
          appBarColor: Colors.pink.shade400,
          body: ListView.builder(
            itemCount: medAssistController.userMedicineStatus?.length,
            itemBuilder: (BuildContext context, int index) {
              final DateFormat showFormat = DateFormat("yyyy-MM-dd HH:mm");
              String transDateString = showFormat.format(stringDateWithTZ.parse(medAssistController.userMedicineStatus?[index].insertDateTime ?? ""));
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: SizedBox(
                      width: 30,
                        child: Image.asset(
                          iconShapeMap[widget.medicineDetails.shape?.replaceAll(" ", "")] ??
                              "assets/icons/pills.webp",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [                    
                          Container(
                          width: MediaQuery.of(context).size.width*0.8,
                            child: Text(widget.medicineDetails.medicineName ?? "" , 
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                    
                            ),
                          ),
                          Text("Med Taken: $transDateString"),
                          // Text("Med Taken: ${DateFormat("yyyy-MM-ddTHH:mm:ss.S").format(DateFormat("yyyy-MM-dd HH:mm").parse(medAssistController.userMedicineStatus?[index].timeTaken ?? ""))}"),
                          Text("Time Taken: ${medAssistController.userMedicineStatus?[index].timeTaken ?? ""}"),
                          Text(medAssistController.userMedicineStatus?[index].reason ?? ""),
                    
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Radio<int>(
                              visualDensity:
                                  const VisualDensity(horizontal: -4, vertical: -4),
                              value: radioTaken,
                              groupValue: skippedValue = medAssistController.userMedicineStatus![index].status,
                              onChanged: (val) {
                                setState(() {
                                  takenValue = val;
                                  log("now radio value 1 @=> $takenValue");
                                });
                              },
                            ),
                            const Text("Token"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<int>(
                              visualDensity:
                                  const VisualDensity(horizontal: -4, vertical: -4),
                              value: radioSkip,
                              groupValue: skippedValue = medAssistController.userMedicineStatus![index].status,
                              onChanged: (val) {
                                setState(() {
                                  skippedValue = val;
                                  log("now radio value 2 @=> $skippedValue");
                                  Get.to(() => ReasonForSkipScreen(updateMedStatus: medAssistController.userMedicineStatus![index]));
                                });
                              },
                            ),
                            const Text("Skip   "),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}
