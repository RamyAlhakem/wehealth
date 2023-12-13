import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../global/styles/text_styles.dart';

class SingleDataSpanFS extends StatelessWidget {
  const SingleDataSpanFS({
    Key? key,
    required this.data,
    required this.title,
    required this.unit,
    this.color,
  }) : super(key: key);
  final String data;
  final String unit;
  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: data,
              style: TextStyles.extraLargeTextBoldStyle().copyWith(
                  color: color ?? Colors.white, fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: " $unit",
                  style: TextStyles.extraSmallText12BStyle().copyWith(
                      fontWeight: FontWeight.normal,
                      color: color ?? Colors.white),
                ),
              ]),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Flexible(
              child: Text(
                title,
                //maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyles.customText(9.0.sp, FontWeight.normal)
                    .copyWith(color: color ?? Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
