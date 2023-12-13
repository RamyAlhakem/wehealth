import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/body_measurement_controller/body_measurement_controller.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/timeline_date_widget.dart';
import '../../../../global/styles/text_styles.dart';
import '../../../../models/body_measurement/body_weight_wrapper.dart';

class BodyWeightTimelineTab extends StatelessWidget {
  const BodyWeightTimelineTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BodyMeasurementController>(builder: (bodyMeasureController) {
      return Column(
        children: [
          HorizontalIconedDataTileAdd(
                data: "${bodyMeasureController.getDateSortedBodyWeightData().lastOrNull?.qty ?? "-"}",
                unit: 'kg',
                iconPath: 'assets/icons/mnu_bweight_l.webp',
              ),
          // const SizedBox(height: 16),
          Expanded(
            child: CustomScrollView(
              slivers: [
                for (MapEntry<DateTime, List<BodyWeightData>> data
                    in bodyMeasureController.bodyWeightTimelineFormat) ...[
                  SliverToBoxAdapter(
                    child: TimelineDateWidget(date: data.key, color: Colors.amber.shade600),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => BodyWeightTimelineDataTile(
                        data: data.value[index]                        
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

class BodyWeightTimelineDataTile extends StatelessWidget {

  const BodyWeightTimelineDataTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final BodyWeightData data;

  //double bmi = 0.0;
  

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormat = DateFormat("hh:mm");
    Color textColor = Colors.amber.shade600;
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        double bmi =  data.qty!.toDouble()  / ((double.parse(profileController.userProfile.height!)/100) * (double.parse(profileController.userProfile.height!)/100));
        log("bmi @ $bmi");
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
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(18),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${data.qty  ?? ""}",
                              style: TextStyles.extraSmallTextStyle()
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "kg",
                          style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade900),
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
                                style: TextStyles.extraSmallTextStyle()
                                    .copyWith(color: Colors.amber.shade600),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text("BMI: ${bmi.toStringAsFixed(0)}         ",
                              style: TextStyles.extraSmallTextStyle().copyWith(fontWeight: FontWeight.normal, color: textColor),
                            ),
                            /* Text("${(data.qty!.toDouble())}  ${(data.height!.toDouble()/100)}  ${(data.height!.toDouble()/100)}   ",
                              style: TextStyles.extraSmallTextStyle().copyWith(fontWeight: FontWeight.normal, color: textColor),
                            ), */
                            Text("Height: ${data.height}",
                              style: TextStyles.extraSmallTextStyle().copyWith(fontWeight: FontWeight.normal, color: textColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text( 
                          " ",
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
    );
  }
}
