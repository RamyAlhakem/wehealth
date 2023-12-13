import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../global/styles/text_styles.dart';

class MeteredGaugeHeartRate extends StatelessWidget {
  const MeteredGaugeHeartRate({
    Key? key,
    required this.needleValue,
  }) : super(key: key);
  final double needleValue;
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 0,
          maximum: 200,
          ranges: [
            GaugeRange(
              startValue: 0,
              endValue: 50,
              color: Colors.orange.shade700,
            ),
            GaugeRange(
              startValue: 51,
              endValue: 100,
              color: Colors.greenAccent,
            ),
            GaugeRange(
              startValue: 100,
              endValue: 200,
              color: Colors.red,
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
                "Heart\n Rate",
                style: TextStyles.extraSmallTextStyle()
                    .copyWith(color: Colors.white),
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
