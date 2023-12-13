// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_controller.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/models/data_model/user_medicine_data_wrapper.dart';
import 'package:wehealth/screens/dashboard/med_assist/add_med_assist_screen.dart';
import 'package:wehealth/screens/dashboard/med_assist/edit_medicine_screen.dart';
import 'package:wehealth/screens/dashboard/med_assist/med_assist_constants.dart';
import 'package:wehealth/screens/dashboard/widgets/all_caught_up_widget.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';
import '../../../global/widgets/ios_close_appbar.dart';
import 'tabs/adherence_tab.dart';
import 'tabs/med_summary.dart';
import 'tabs/my_medicine_tab.dart';

class MedAssistDashboardScreen extends StatefulWidget {
  const MedAssistDashboardScreen({Key? key}) : super(key: key);

  @override
  State<MedAssistDashboardScreen> createState() =>
      _MedAssistDashboardScreenState();
}

class _MedAssistDashboardScreenState extends State<MedAssistDashboardScreen> {
  final pageColor = Colors.pinkAccent;

  @override
  void initState() {
    super.initState();
    final controller = Get.put(MedAssistController());
    controller.fetchMedicineData();
    controller.fetchMedicineStatusData();
    controller.fetchUsersMedicineData();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Med Assist",
      appBarColor: pageColor,
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.hardEdge,
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Get.to(() => const MedAssistScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            "assets/icons/pills.webp",
            fit: BoxFit.contain,
          ),
        ),
      ),
      tabCount: 3,
      tabTitles: const [
        "SUMMARY",
        "MY MEDICINE",
        "ADHERENCE SCORE",
      ],
      tabs: const [
        MedAssistSummaryTab(),
        MedAssistMedicineTab(),
        MedAssistAdherenceTab(),
      ],
    );
  }
}

class DayPortionMedicineScreen extends StatelessWidget {
  const DayPortionMedicineScreen({
    Key? key,
    required this.title,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Med Assist",
      appBarColor: Colors.pinkAccent,
      body: GetBuilder<MedAssistController>(builder: (controller) {
        final dataList = (controller.myMedicineList ?? [])
            .where(
                (element) => element.formattedEndDate.isAfter(DateTime.now()))
            .where(
              (element) => (element.days ?? "")
                  .split(",")
                  .contains(DateTime.now().weekDayCodeString),
            )
            .where(
              (element) =>
                  element.timeOfTaking.inInclusiveRange(startTime, endTime),
            )
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      "${DateFormat.jm().format(startTime.toTodayDateTime)} to ${DateFormat.jm().format(endTime.toTodayDateTime)}",
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 3,
              color: Colors.black54,
            ),
            Expanded(
              child: (dataList.isEmpty)
                  ? const AllCaughtUpWidget(
                      endLine: "You don't have any medicines!")
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final item = dataList[index];
                        return ShowMedicineListTile(item: item);
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}

class ShowMedicineListTile extends StatelessWidget {
  const ShowMedicineListTile({Key? key, required this.item}) : super(key: key);

  final UserMedicineData item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: (){
      Get.to(()=>EditMedicineDetailsScreen(data: item));
    },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
            width: 0.6,
          ),
        ),
        leading: SizedBox(
          width: 40,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              iconShapeMap[item.shape?.replaceAll(" ", "")] ??
                  "assets/icons/pills.webp",
            ),
          ),
        ),
        title: Text(
          (item.formattedEndDate.isBefore(DateTime.now()))
              ? "Expired ${DateTime.now().difference(item.formattedEndDate).inDays} days ago"
              : "Gonna Expire in ${item.formattedEndDate.difference(DateTime.now()).inDays}",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        subtitle: Text(
          item.medicineName!,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
