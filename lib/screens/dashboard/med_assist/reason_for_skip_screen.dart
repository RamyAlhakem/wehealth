import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_controller.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';

import '../../../models/data_model/medicine_status_model.dart';

class ReasonForSkipScreen extends StatefulWidget {
  final MedicineStatusModel updateMedStatus;
  const ReasonForSkipScreen({super.key, required this.updateMedStatus});

  @override
  State<ReasonForSkipScreen> createState() => _ReasonForSkipScreenState();
}

class _ReasonForSkipScreenState extends State<ReasonForSkipScreen> {
  List<String> skipReasons = [
    "Ran Out Of Medicine",
    "Forgot",
    "Busy",
    "Changes in daily routine",
    "Away from home",
    "Feeling sick/ill",
    "Side effects",
    "Too many medicines to take",
    "Medicine lost/stolen",
    "Medicine too expensive",
    "Feeling Healthy",
    "Problems taking before/after food",
    "Other Reasons",
  ];
  var selectedIndexes = [];

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Reasons For Skipping",
      appBarColor: Colors.pink.shade400,
      body: Column(
        children: [
          Expanded(
          flex: 10,
            child: ListView.builder(
              itemCount: skipReasons.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Colors.pink.shade400,
                            value: selectedIndexes.contains(skipReasons[index]),
                            onChanged: (val) {
                              setState(() {
                                if (selectedIndexes
                                    .contains(skipReasons[index])) {
                                  selectedIndexes.remove(skipReasons[index]);
                                } else {
                                  selectedIndexes.add(skipReasons[index]);
                                }
                                log(selectedIndexes.toString());
                              });
                            }),
                        Text(skipReasons[index],
                            style: TextStyle(color: Colors.pink.shade400)),
                      ],
                    ),
                    Divider(
                        height: 1, thickness: 1, color: Colors.grey.shade400),
                  ],
                );
              },
            ),
          ),
          const Spacer(),
          Expanded(
          flex: 1,
            child: Row(
              children: [
                SizedBox(
                    height: 50,
            width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.pink)),
                    onPressed: () {
                      /* 
                      print("${widget.updateMedStatus.id}");
                      print("${widget.updateMedStatus.myMedicineID}");
                      print("${widget.updateMedStatus.userID}");
                      print("${widget.updateMedStatus.status} will be zero 0");
                      print("${widget.updateMedStatus.dateTime}");
                      print("${widget.updateMedStatus.insertDateTime}");
                      print("${widget.updateMedStatus.timeTaken}");
                      print("${widget.updateMedStatus.reason}");                   
                      print(selectedIndexes.reduce((value, element) => value + "," + element)); 
                      */
                      String reasons = selectedIndexes.reduce((value, element) => value + "," + element);
                      final data = MedicineStatusModel(
                      id: widget.updateMedStatus.id,
                      myMedicineID: widget.updateMedStatus.myMedicineID,
                      userID: widget.updateMedStatus.userID,
                      status: 0,
                      dateTime: widget.updateMedStatus.dateTime,
                      insertDateTime: widget.updateMedStatus.insertDateTime,
                      timeTaken: widget.updateMedStatus.timeTaken,
                      reason: reasons,

                      );

                      Get.find<MedAssistController>().updateMedAdhereStatus(data);
                    },
                    child: const Text("SUBMIT"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
