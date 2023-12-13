import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';

class HorizontalIconedDataTileFacebook extends StatelessWidget {
  const HorizontalIconedDataTileFacebook({
    Key? key,
    required this.color,
    required this.iconPath,
    required this.data,
    required this.unit,
  }) : super(key: key);

  final Color color;
  final String iconPath;
  final String data;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: 90.h,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        iconPath,
                        color: color,
                      ),
                      SizedBox(width: 5.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              data,
                              style: TextStyles.normalTextBoldStyle()
                                  .copyWith(color: color),
                            ),
                          ),
                          Text(
                            unit,
                            style: TextStyles.extraSmallBoldTextStyle()
                                .copyWith(color: color),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 70.w,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SfCircularChart(
                            margin: EdgeInsets.zero,
                            series: <CircularSeries>[
                              DoughnutSeries<ChartData, String>(
                                radius: "100%",
                                dataSource: <ChartData>[
                                  ChartData("Obtained Score", 20, Colors.grey),
                                  ChartData("Total Score", 50, Colors.grey),
                                ],
                                pointColorMapper: (ChartData data, _) =>
                                    data.color,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                name: "data",
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child:
                              Image.asset("assets/icons/facebookcircle.webp"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalIconedDataTileAdd extends StatelessWidget {
  const HorizontalIconedDataTileAdd({
    Key? key,
    required this.iconPath,
    required this.data,
    this.unit,
    this.seconderyWidget,
    this.baseColor,
    this.onAddClick,
  }) : super(key: key);
  final String iconPath;
  final String data;
  final String? unit;
  final Color? baseColor;
  final VoidCallback? onAddClick;
  final Widget? seconderyWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82.h,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0.sp),
              child: InkWell(
                child: Image.asset(
                  iconPath,
                  color: baseColor ?? Colors.amber.shade700,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data,
                  style: TextStyles.smallTextBoldStyle().copyWith(
                    color: baseColor ?? Colors.amber.shade700,
                    fontSize: 20.sp,
                  ) /* TextStyles.smallTextStyle()
                      .copyWith(color: baseColor ?? Colors.amber.shade700) */
                  ,
                ),
                if (unit != null)
                  Text(
                    unit!,
                    style: TextStyles.smallTextStyle().copyWith(
                      color: baseColor ?? Colors.amber.shade700,
                    ),
                  ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (seconderyWidget != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox.square(
                            dimension: 50.h, child: seconderyWidget),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: onAddClick,
                        padding: EdgeInsets.zero,
                        iconSize: 50.sp,
                        icon: Icon(
                          Icons.add_circle,
                          color: baseColor ?? Colors.amber.shade700,
                          // size: 50,
                        ),
                      ),
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

class HorizontalIconedDataOnlyTile extends StatelessWidget {
  const HorizontalIconedDataOnlyTile({
    Key? key,
    required this.color,
    required this.iconPath,
    required this.data,
    required this.unit,
    this.emptyValue =0,
  }) : super(key: key);

  final Color color;
  final String iconPath;
  final String data;
  final String unit;
  final double emptyValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        iconPath,
                        color: color,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data,
                            style: TextStyles.normalTextBoldStyle()
                                .copyWith(color: color),
                          ),
                          Text(
                            unit,
                            style: TextStyles.extraSmallBoldTextStyle()
                                .copyWith(color: color),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const Spacer(),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: SfCircularChart(
                          margin: EdgeInsets.zero,
                          series: <CircularSeries>[
                            DoughnutSeries<ChartData, String>(
                              radius: "100%",
                              dataSource: <ChartData>[
                                ChartData(
                                  "Obtained Score",
                                  double.parse(data),
                                  Colors.green.shade800,
                                ),
                                ChartData(
                                  "Total Score",
                                  emptyValue,
                                  Colors.grey,
                                ),
                              ],
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
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
            ],
          ),
        ),
      ),
    );
  }
}
