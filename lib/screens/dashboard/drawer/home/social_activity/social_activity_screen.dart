import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/social_activity/social_details_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import 'package:wehealth/screens/dashboard/widgets/image_tile_button.dart';

class SocialActivityScreen extends StatefulWidget {
  const SocialActivityScreen({Key? key}) : super(key: key);

  @override
  State<SocialActivityScreen> createState() => _SocialActivityScreenState();
}

class _SocialActivityScreenState extends State<SocialActivityScreen> {
  final pageColor = Colors.purple;
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Social Activities",
      appBarColor: pageColor,
      body: Column(
        children: [
          const SizedBox(height: 8),
          SizedBox(
            height: 150.h,
            child: const MeteredGaugeSocialActivity(needleValue: 6),
          ),
          const SizedBox(height: 16),
          SocialActivityDataCard(),
          const SizedBox(height: 12),
          Text(
            "Social Activities",
            style: TextStyles.normalTextBoldStyle(),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ImageTileButton(
                  image: "assets/images/sport_walking.webp",
                  color: Colors.purple,
                  title: "Walking",
                  onTap: () {},
                ),
                ImageTileButton(
                    image: "assets/images/sport_running.webp",
                    color: Colors.purple,
                    onTap: () {},
                    title: "Jogging"),
                ImageTileButton(
                    image: "assets/images/sport_mountain.webp",
                    color: Colors.purple,
                    onTap: () {},
                    title: "climbing"),
                ImageTileButton(
                    image: "assets/images/sport_bicycle.webp",
                    color: Colors.purple,
                    onTap: () {},
                    title: "Cycling"),
                ImageTileButton(
                    image: "assets/images/cyclinguphills.webp",
                    color: Colors.purple,
                    onTap: () {},
                    title: "Cycling Up Hills"),
                ImageTileButton(
                    image: "assets/images/sport_yoga.webp",
                    color: Colors.purple,
                    onTap: () {},
                    title: "Yoga"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SocialActivityDataCard extends StatelessWidget {
  const SocialActivityDataCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Get.to(() => const SocialDetailsScreen());
      },
      child: Container(
        height: 80,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    flex: 5,
                    child: FittedBox(
                      child: Text(
                        "00:00 hh:mm",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: FittedBox(
                        child: Text(
                          "Social Activities",
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                child: SfCircularChart(
                  annotations: [
                    CircularChartAnnotation(
                      widget: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '',
                          textAlign: TextAlign.center,
                          style: TextStyles.extraSmallTextStyle(),
                        ),
                      ),
                    ),
                  ],
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                      radius: "100%",
                      dataSource: <ChartData>[
                        ChartData("Total Score", 50, Colors.purple),
                        ChartData("Obtained Score", 60, Colors.purple.shade50),
                      ],
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      name: "data",
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

class MeteredGaugeSocialActivity extends StatelessWidget {
  const MeteredGaugeSocialActivity({
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
              endValue: 40,
              color: Colors.purple.shade100,
            ),
            GaugeRange(
              startValue: 40,
              endValue: 70,
              color: Colors.purple.shade400,
            ),
            GaugeRange(
              startValue: 70,
              endValue: 100,
              color: Colors.purple.shade800,
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
                "Sleep\n Quality",
                textAlign: TextAlign.center,
                style: TextStyles.extraSmallTextStyle().copyWith(
                  color: Colors.purple,
                ),
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
