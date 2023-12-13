import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RectAngleBox extends StatelessWidget {
  const RectAngleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffFFFFFF),
          width: 0.5.w,
        ),
      ),
      // height: getProportionateScreenHeight(19),
      // width: getProportionateScreenWidth(48),
      height: 19.h,
      width: 48.w,
    );
  }
}
