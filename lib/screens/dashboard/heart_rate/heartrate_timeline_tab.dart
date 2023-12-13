import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/heart_rate_controller/heart_rate_controller.dart';
import 'package:wehealth/models/data_model/fetch_heart_rate_model.dart';
import 'package:wehealth/screens/dashboard/heart_rate/add_manual_heartrate.dart';
import 'package:wehealth/screens/dashboard/heart_rate/heartrate_trends_tab.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/timeline_date_widget.dart';

import '../../../global/styles/text_styles.dart';

class HeartRateTimelineTab extends StatefulWidget {
  const HeartRateTimelineTab({
    Key? key,
  }) : super(key: key);

  @override
  State<HeartRateTimelineTab> createState() => _HeartRateTimelineTabState();
}

class _HeartRateTimelineTabState extends State<HeartRateTimelineTab> {
  List<MapEntry<DateTime, List<HeartRateFetchModel>>>? timeline;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await Get.showOverlay(
        loadingWidget: const OverlayLoadingIndicator(),
        asyncFunction: () async {
          final controller = Get.find<HeartRateController>();
          timeline = await controller.heartRateTimelineFormat();
          controller.getHeartRateDataByType(1, true);
        },
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HeartRateController>(builder: (controller) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: HorizontalAddCameraIconedDataTile(
              data:
                  "${controller.typeCacheMap[1]?.lastOrNull?.heartRateQty ?? 0}",
              pageColor: Colors.orange,
              addButtonClick: () {
                Get.to(() => const ManualHeartRateWidget());
              },
              cameraButtonClick: () {},
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: CustomScrollView(
              slivers: [
                for (MapEntry<DateTime, List<HeartRateFetchModel>> data
                    in timeline ?? []) ...[
                  SliverToBoxAdapter(
                    child: TimelineDateWidget(date: data.key),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => HeartRateTimelineDataTile(
                        data: data.value[index],
                      ),
                      childCount: data.value.length,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      );
    });
  }
}

class HeartRateTimelineDataTile extends StatelessWidget {
  const HeartRateTimelineDataTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final HeartRateFetchModel data;

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormat = DateFormat("hh:mm");
    return InkWell(
      onTap: () async {},
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 100,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade700,
            ),
            bottom: BorderSide(
              color: Colors.grey.shade700,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${data.heartRateQty ?? ""}",
                          style: TextStyles.extraSmallText12BStyle()
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "bpm",
                      style: TextStyle(
                          fontSize: 10.sp, color: Colors.grey.shade900),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            timeFormat.format(data.recordDate),
                            style: TextStyles.extraSmallBoldTextStyle()
                                .copyWith(color: Colors.grey.shade700),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          (data.heartRateType == 1) ? "Activity" : "Resting",
                          style: TextStyles.extraSmallTextStyle()
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "No notes found!",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
