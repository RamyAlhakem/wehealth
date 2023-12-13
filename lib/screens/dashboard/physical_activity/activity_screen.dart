// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/controller/google_fit_controller/google_fit_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/physical_activity/calories_record_screen.dart';
import 'package:wehealth/screens/dashboard/physical_activity/distance_record_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';
import '../widgets/image_list_tile.dart';
import 'other_activity.dart';
import 'steps_record_screen.dart';

class PhysicalActivityDetailsScreen extends StatefulWidget {
  const PhysicalActivityDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PhysicalActivityDetailsScreen> createState() =>
      _PhysicalActivityDetailsScreenState();
}

class _PhysicalActivityDetailsScreenState
    extends State<PhysicalActivityDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Activity",
      tabCount: 2,
      tabTitles: const ["PHYSICAL ACTIVITY", "OTHER ACTIVITY"],
      tabs: const [
        PhysicalActivityTab(),
        OtherActivityTab(),
      ],
    );
  }
}

class PhysicalActivityTab extends StatelessWidget {
  const PhysicalActivityTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoogleFitController>(builder: (controller) {
      return Column(
        children: [
          SizedBox(height: 8),
          SizedBox(
            height: 150.h,
            child: MeteredGaugeActivity(
              needleValue: 0,
            ),
          ),
          SizedBox(height: 8),
          ImageListTile(
            image: "assets/images/stepdashboard.webp",
            data: /* controller.dailySteps.toStringAsFixed(0) */ "0",
            unit: "Steps",
            subtitle: "Daily Steps Goal: 10000 steps",
            leadingBorderColor: Colors.blue.shade200,
            onTap: () {
              Get.to(() => const StepsRecordScreen());
            },
          ),
          SizedBox(height: 8),
          ImageListTile(
            image: "assets/images/caloriesdashboard.webp",
            data: /* controller.dailyActiveEnergy.toStringAsFixed(0) */ "0",
            unit: "kcal",
            subtitle: "Daily Calories Burned Goal: 1250 kcal",
            leadingBorderColor: Colors.blue.shade200,
            onTap: () {
              Get.to(() => const CaloriesRecordScreen());
            },
          ),
          SizedBox(height: 8),
          ImageListTile(
            image: "assets/images/distance.webp",
            data: /* controller.dailyDistance.toStringAsFixed(0) */ "0",
            unit: "meters",
            subtitle: "Daily Distance Goal: 40 meters",
            leadingBorderColor: Colors.blue.shade200,
            onTap: () {
              Get.to(() => const DistanceRecordScreen());
            },
          ),
        ],
      );
    });
  }
}

class MeteredGaugeActivity extends StatelessWidget {
  const MeteredGaugeActivity({
    Key? key,
    required this.needleValue,
  }) : super(key: key);
  final double needleValue;
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      // title: GaugeTitle(text: "Physical Activity"),
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: 100,
          ranges: [
            GaugeRange(
              startValue: 0,
              endValue: 33,
              color: Colors.blue.shade200,
            ),
            GaugeRange(
              startValue: 33,
              endValue: 66,
              color: Colors.blue.shade400,
            ),
            GaugeRange(
              startValue: 66,
              endValue: 100,
              color: Colors.blue.shade600,
            ),
          ],
          pointers: [
            NeedlePointer(
              value: needleValue,
              enableAnimation: true,
              animationDuration: 1000,
              needleEndWidth: 5,
              knobStyle: const KnobStyle(color: Colors.grey),
            ),
          ],
          annotations: [
            GaugeAnnotation(
              widget: Text(
                "Physical\n Activity",
                style: TextStyles.extraSmallTextStyle()
                    .copyWith(color: Colors.blue.shade300),
              ),
              positionFactor: 0.9,
              angle: 90,
            )
          ],
        )
      ],
    );
  }
}
