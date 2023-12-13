import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../global/styles/text_styles.dart';

class MeteredGaugeBloodOxygen extends StatelessWidget {
  const MeteredGaugeBloodOxygen({
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
          maximum: 100,
          ranges: [
            GaugeRange(
              startValue: 0,
              endValue: 93,
              color: Colors.red,
            ),
            GaugeRange(
              startValue: 93,
              endValue: 100,
              color: Colors.green,
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
                "Blood\n Oxygen",
                textAlign: TextAlign.center,
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
