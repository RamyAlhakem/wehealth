import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_pressure_controller/blood_pressure_controller.dart';
import 'package:wehealth/controller/user_devices_controller/user_devices_controller.dart';
import 'package:wehealth/models/data_model/user_bp_model.dart';
import 'package:wehealth/screens/dashboard/blood_pressure/manual_blood_pressure.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/timeline_data_tile.dart';
import 'package:wehealth/screens/dashboard/widgets/timeline_date_widget.dart';
import '../../../global/styles/text_styles.dart';

class BloodPressureTimelineTab extends StatefulWidget {
  const BloodPressureTimelineTab({
    Key? key,
  }) : super(key: key);

  @override
  State<BloodPressureTimelineTab> createState() =>
      _BloodPressureTimelineTabState();
}

class _BloodPressureTimelineTabState extends State<BloodPressureTimelineTab> {
  List<MapEntry<DateTime, List<BPData>>>? timeline;
  @override
  void initState() {
    super.initState();
    /* timeline = Get.find<BloodPressureController>()
        .getDateSortedBpData()
        .groupListsBy((element) => DateTime(element.recordDate.year,
            element.recordDate.month, element.recordDate.day))
        .entries
        .toList(); */
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Get.showOverlay(
          loadingWidget: const OverlayLoadingIndicator(),
          asyncFunction: () async {
            final controller = Get.find<BloodPressureController>();
            // await controller.dateSortBpData();
            timeline = await Future.value(controller.currentSortedList
                .groupListsBy((element) => DateTime(element.recordDate.year,
                    element.recordDate.month, element.recordDate.day))
                .entries
                .toList());
            setState(() {});
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BloodPressureController>(builder: (controller) {
      return Column(
        children: [
          // ========>| COMMON Portion |<======== //
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 60.h,
              child: Row(
                children: [
                  InkWell(
                    child: Image.asset(
                      "assets/images/mnu_bp_l.webp",
                      color: Colors.orange.shade700,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.currentSortedList.lastOrNull?.systolic ?? 0}/${controller.currentSortedList.lastOrNull?.diastolic ?? 0}",
                        style: TextStyles.largeTextStyle().copyWith(
                            color: Colors.orange.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "mmHg",
                        style: TextStyles.extraSmallText12BStyle()
                            .copyWith(color: Colors.orange.shade700),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: !Get.find<UserDevicesController>().hasBloodPressureDevice
                        ? const SizedBox()
                        : Image.asset(
                            "assets/icons/devices/bp_microlife_not_connected.png",
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.to(() => const ManualBloodPressureWidget());
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.orange.shade700,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ======>| COMMON Portion |<====== //
          const SizedBox(height: 18),
          Expanded(
            child: CustomScrollView(
              slivers: [
                for (MapEntry<DateTime, List<BPData>> a
                    in timeline?.reversed.toList() ?? []) ...[
                  SliverToBoxAdapter(
                    child: TimelineDateWidget(
                      date: a.key,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final data = a.value[index];
                        return TimelineDataTile(
                          leadingData: "${data.systolic}/${data.diastolic}",
                          leadingUnit: "mmHg",
                          titleData: "Pulse Rate : ${data.pulserate} bpm",
                          noteData: "${data.notes}",
                          timeData: data.recordDate,
                          onTap: () {
                            //
                            log("update on processing..");
                          },
                          leadingColor: Colors.green.shade400,
                          textColor: Colors.orange.shade700,
                        );
                      },
                      childCount: a.value.length,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    });
  }
}
