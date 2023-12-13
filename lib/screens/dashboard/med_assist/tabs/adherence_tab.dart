import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_controller.dart';
import 'package:wehealth/models/data_model/user_medicine_data_wrapper.dart';
import 'package:wehealth/screens/dashboard/med_assist/med_assist_constants.dart';
import 'package:wehealth/screens/dashboard/widgets/all_caught_up_widget.dart';
import '../medcine_history.dart';

class MedAssistAdherenceTab extends StatelessWidget {
  const MedAssistAdherenceTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: GetBuilder<MedAssistController>(builder: (controller) {
          return (controller.myMedicineList != null)
              ? Wrap(
                  alignment: WrapAlignment.start,
                  children: controller.myMedicineList!
                      .map(
                        (item) => AdherenceDataTile(
                          data: item,
                        ),
                      )
                      .toList(),
                )
              : const AllCaughtUpWidget(endLine: "No medicine Data found!");
        }),
      ),
    );
  }
}

class AdherenceDataTile extends StatelessWidget {
  const AdherenceDataTile({Key? key, required this.data}) : super(key: key);

  final UserMedicineData data;
  @override
  Widget build(BuildContext context) {
    log(data.toJson().toString());
    return GestureDetector(
      onTap: () {
        Get.to(() => TakenOrSkip(medicineDetails: data));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
        child: SizedBox(
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade100.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      iconShapeMap[data.shape?.replaceAll(" ", "")] ??
                          "assets/icons/pills.webp",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                data.medicineName!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Started at ${data.startDate}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "-%",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
