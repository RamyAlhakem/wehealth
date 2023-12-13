import 'package:flutter/material.dart';

import '../../../global/styles/text_styles.dart';

class IndicatorData extends StatelessWidget {
  const IndicatorData({
    Key? key,
    required this.color,
    required this.tag,
    this.isHorizontal = false,
    this.textColor,
  }) : super(key: key);
  final Color color;
  final String tag;
  final Color? textColor;
  final bool isHorizontal; 
  @override
  Widget build(BuildContext context) {
    return isHorizontal? Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
        Text(
          tag,
          style: TextStyles.extraSmallBoldTextStyle()
              .copyWith(color: textColor ?? Colors.white),
        )
      ],
    ) : Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
        Text(
          tag,
          style: TextStyles.extraSmallBoldTextStyle()
              .copyWith(color: textColor ?? Colors.white),
        )
      ],
    );
  }
}
