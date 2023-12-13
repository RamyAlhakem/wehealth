import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../global/styles/text_styles.dart';

class CustomGauge extends StatelessWidget {
  const CustomGauge({
    Key? key,
    this.title,
    required this.textColor,
    required this.needleValue,
    required this.start,
    required this.end,
    required this.gaugeRanges,
    this.knobColor,
  }) : super(key: key);
  final String? title;
  final double needleValue;
  final double start;
  final double end;
  final Color textColor;
  final List<GaugeRange> gaugeRanges;

  final Color? knobColor;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: start,
          maximum: end,
          ranges: [...gaugeRanges],
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
            if (title != null && title!.isNotEmpty)
              GaugeAnnotation(
                widget: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyles.extraSmallTextStyle()
                      .copyWith(color: textColor),
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
