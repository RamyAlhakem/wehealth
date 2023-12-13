import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_controller.dart';
import 'package:wehealth/screens/dashboard/med_assist/edit_medicine_screen.dart';
import 'package:wehealth/screens/dashboard/med_assist/med_assist_dashboard.dart';
import 'package:wehealth/screens/dashboard/widgets/all_caught_up_widget.dart';

class MedAssistMedicineTab extends StatelessWidget {
  const MedAssistMedicineTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedAssistController>(builder: (controller) {
      return (controller.myMedicineList != null)
          ? ListView.builder(
              itemCount: controller.myMedicineList?.length,
              itemBuilder: (context, index) {
                final item = controller.myMedicineList![index];
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => EditMedicineDetailsScreen(
                        data: item,
                      ),
                    );
                  },
                  child: ShowMedicineListTile(item: item),
                );
              },
            )
          : const AllCaughtUpWidget(endLine: "No medicine Data found!");
    });
  }
}
