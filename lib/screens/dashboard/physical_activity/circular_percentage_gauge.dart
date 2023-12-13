import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../global/styles/text_styles.dart';

class CircularPercentageGauge extends StatelessWidget {
  const CircularPercentageGauge({
    Key? key,
    required this.percentageValue,
    this.title,
  }) : super(key: key);

  final String percentageValue;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return SizedBox.square(
          dimension: constrains.maxHeight,
          child: SfRadialGauge(
           title: GaugeTitle(
              text: title ?? "Of Total Goal",
              alignment: GaugeAlignment.center,
              textStyle: TextStyles.extraSmallBoldTextStyle()
                  .copyWith(color: Colors.white),
            ),
            animationDuration: 800,
            enableLoadingAnimation: true,
            axes: [
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                axisLineStyle: const AxisLineStyle(
                  thickness: 1,
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: double.parse(percentageValue),
                    width: 0.15,
                    color: Colors.white54,
                    pointerOffset: 0.1,
                    cornerStyle: CornerStyle.bothCurve,
                    sizeUnit: GaugeSizeUnit.factor,
                  )
                ],
                canScaleToFit: true,
                showAxisLine: true,
                annotations: [
                  GaugeAnnotation(
                    positionFactor: 0.5,
                    widget: Text(
                      "$percentageValue%",
                      style: TextStyles.extraLargeTextBoldStyle()
                          .copyWith(color: Colors.white54),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
