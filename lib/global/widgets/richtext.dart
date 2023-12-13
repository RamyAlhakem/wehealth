import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRichText extends StatelessWidget {
  final String titleText;
  final String optional;
  final String description;
  final GestureRecognizer onTap;
  const CustomRichText(
      {Key? key,
      required this.titleText,
      required this.optional,
      required this.description,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: titleText,
        style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          fontSize: 12.sp,
        ),
        children: <TextSpan>[
          TextSpan(
            text: description,
            recognizer: onTap,
            style: TextStyle(
              color: Colors.blue,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: optional,
            recognizer: onTap,
            style: TextStyle(
              color: Colors.black87,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
