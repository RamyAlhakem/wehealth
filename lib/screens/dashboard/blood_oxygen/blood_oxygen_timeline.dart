import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_oxygen_controller/blood_oxygen_controller.dart';
import 'package:wehealth/models/data_model/blood_oxygen_data_fetch_wrapper.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/timeline_data_tile.dart';
import 'package:wehealth/screens/dashboard/widgets/timeline_date_widget.dart';

import 'manual_blood_oxygen_widget.dart';

class BloodOxygenTimelineTab extends StatefulWidget {
  const BloodOxygenTimelineTab({
    Key? key,
  }) : super(key: key);

  @override
  State<BloodOxygenTimelineTab> createState() => _BloodOxygenTimelineTabState();
}

class _BloodOxygenTimelineTabState extends State<BloodOxygenTimelineTab> {
  List<MapEntry<DateTime, List<BloodOxygenData>>> dataList = [];

  @override
  void initState() {
    super.initState();
    dataList =
        Get.find<BloodOxygenController>().getTimelineFormat().entries.toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BloodOxygenController>(builder: (controller) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: HorizontalIconedDataTileAdd(
              iconPath: "assets/images/mnu_bo_l.webp",
              data:
                  "${controller.getTheSortedList.lastOrNull?.oxygenlevel ?? 0}%",
              onAddClick: () {
                Get.to(() => const ManualBloodOxygenWidget());
              },
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                for (MapEntry<DateTime, List<BloodOxygenData>> a
                    in dataList.reversed.toList()) ...[
                  SliverToBoxAdapter(
                    child: TimelineDateWidget(date: a.key),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final data = a.value[index];
                        return TimelineDataTile(
                          leadingData: "${data.oxygenlevel}",
                          leadingUnit: "%",
                          titleData: "Pulse Rate : ${data.pulse} bpm",
                          noteData:
                              (data.notes == null || data.notes!.isEmpty)
                                  ? "No notes found!"
                                  : data.notes!,
                          timeData: data.recordDate,
                          onTap: () {},
                          leadingColor: Colors.green,
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
