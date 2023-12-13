import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/user_medication_task_wrapper.dart';
import 'package:wehealth/screens/dashboard/widgets/all_caught_up_widget.dart';

class NotificationCarePlanTab extends StatefulWidget {
  const NotificationCarePlanTab({ 
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationCarePlanTab> createState() =>
      _NotificationCarePlanTabState();
}

class _NotificationCarePlanTabState extends State<NotificationCarePlanTab>
    with TickerProviderStateMixin {
  late final TabController _controller;
  @override
  void initState() {
    super.initState();
    int index = DateTime.now().weekday == 7 ? 0 : (DateTime.now().weekday);

    DateTime.saturday;
    _controller = TabController(length: 7, vsync: this, initialIndex: index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColoredBox(
          color: Colors.grey.shade200,
          child: TabBar(
            controller: _controller,
            isScrollable: true,
            labelColor: Colors.red,
            indicatorWeight: 3,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.black,
            tabs: [
              "SUN",
              "MON",
              "TUE",
              "WED",
              "THU",
              "FRI",
              "SAT",
            ]
                .map(
                  (e) => Tab(
                    text: e,
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: GetBuilder<MedAssistController>(builder: (controller) {
            return TabBarView(
              controller: _controller,
              children: [
                DayTabCarePlan(
                  data: controller.userMedicineTaskByDay("sun"),
                ),
                DayTabCarePlan(
                  data: controller.userMedicineTaskByDay("mon"),
                ),
                DayTabCarePlan(
                  data: controller.userMedicineTaskByDay("tue"),
                ),
                DayTabCarePlan(
                  data: controller.userMedicineTaskByDay("wed"),
                ),
                DayTabCarePlan(
                  data: controller.userMedicineTaskByDay("thr"),
                ),
                DayTabCarePlan(
                  data: controller.userMedicineTaskByDay("fri"),
                ),
                DayTabCarePlan(
                  data: controller.userMedicineTaskByDay("sat"),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class DayTabCarePlan extends StatelessWidget {
  const DayTabCarePlan({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<UserMedicationTaskModel> data;

  List<UserMedicationTaskModel> get getExpandedList =>
      data.expand<UserMedicationTaskModel>((element) {
        return element.todaytime
                ?.split(',')
                .map(
                  (e) => element.copyWith(todaytime: e),
                )
                .toList() ??
            [];
      }).toList();

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const AllCaughtUpWidget(endLine: "There are no new task.")
        : ListView.builder(
            itemCount: getExpandedList.length,
            itemBuilder: (BuildContext context, int index) {
              return SingleCarePlanTile(
                medicineData: getExpandedList[index],
              );
            },
          );
  }
}

class SingleCarePlanTile extends StatelessWidget {
  const SingleCarePlanTile({
    Key? key,
    required this.medicineData,
  }) : super(key: key);

  final UserMedicationTaskModel medicineData;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 60.h,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset("assets/icons/medassisttdb.webp"),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    "MEDICATION",
                    style: TextStyles.extraSmallDaysTextStyle()
                        .copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  "🕛 ${DateFormat("h:mm a").format(medicineData.formattedTime)}",
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Take ${medicineData.medicineName}",
              softWrap: true,
              style: TextStyles.extraSmallDaysTextStyle()
                  .copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
