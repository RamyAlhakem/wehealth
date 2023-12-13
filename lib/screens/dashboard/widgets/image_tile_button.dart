import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/styles/text_styles.dart';

class ImageTileButton extends StatelessWidget {
  const ImageTileButton({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
    this.color,
  }) : super(key: key);
  final String image;
  final String title;
  final VoidCallback onTap;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 55.h,
              child: Image.asset(
                image,
                color: color ?? Colors.blue.shade200,
              )),
          SizedBox(height: 8.h),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.extraSmallDaysTextStyle()
                .copyWith(color: color ?? Colors.blue.shade200),
          )
        ],
      ),
    );
  }
}
