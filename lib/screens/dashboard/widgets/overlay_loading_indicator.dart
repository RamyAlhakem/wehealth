import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wehealth/global/styles/text_styles.dart';

class OverlayLoadingIndicator extends StatelessWidget {
  const OverlayLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black26,
      child: Center(
        child: Container(
          height: 125.h,
          width: 120.w,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CircularProgressIndicator(),
              Text("Loading...", 
              style: TextStyles.extraSmallTextStyle(),
              maxLines: 1,
              overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
