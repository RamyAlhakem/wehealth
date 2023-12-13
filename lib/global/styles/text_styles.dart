import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  //:::::::::::::::::::
  static TextStyle customText(double fontSize, FontWeight? fontWEight) {
    return TextStyle(
      fontFamily: 'monserrat',
      fontWeight: fontWEight ?? FontWeight.normal,
      fontSize: fontSize,
    );
  }

  //:::::::::::::::::::
  static TextStyle extraSmallDaysTextStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontSize: 12.sp,
    );
  }

  static TextStyle extraSmallText12BStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontSize: 12.sp,
      fontWeight: FontWeight.w600, 
      overflow: TextOverflow.fade,
    );
  }

  static TextStyle extraSmallTextStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontSize: 14.sp,
      //fontWeight: FontWeight.w600
    );
  }

  static TextStyle extraSmallText14BStyle() {
    return TextStyle(
        fontFamily: 'monserrat', fontSize: 14.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle extraSmallTextButtonStyle() {
    return TextStyle(
        fontFamily: 'monserrat', fontSize: 14.sp, fontWeight: FontWeight.w900);
  }

  static TextStyle smallTextStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontSize: 16.sp,
    );
  }

  static TextStyle normalTextStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontSize: 18.sp,
    );
  }

  static TextStyle largeTextStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontSize: 20.sp,
    );
  }

  static TextStyle extraLargeTextStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontSize: 22.sp,
    );
  }

  static TextStyle extraSmallBoldTextStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      //fontWeight: FontWeight.bold,
      fontSize: 12.sp,
    );
  }

  static TextStyle smallTextBoldStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontWeight: FontWeight.bold,
      fontSize: 16.sp,
    );
  }

  static TextStyle normalTextBoldStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontWeight: FontWeight.bold,
      fontSize: 18.sp,
    );
  }

  static TextStyle textGreyBoldStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey.shade700,
      fontSize: 16.sp,
    );
  }

  static TextStyle largeTextBoldStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontWeight: FontWeight.bold,
      fontSize: 20.sp,
    );
  }

  static TextStyle extraLargeTextBoldStyle() {
    return TextStyle(
      fontFamily: 'monserrat',
      fontWeight: FontWeight.bold,
      fontSize: 22.sp,
    );
  }

  //:::::::::::::::::::
}
