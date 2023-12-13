import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wehealth/controller/theme_controller.dart';
import 'package:get/get.dart';

class ColorResources {
  BuildContext context;
  ColorResources(this.context);
  static ThemeController t = Get.put(ThemeController());

  static Color getRedColor(context) {
    bool isDark = Get.isDarkMode;
    log("Getx Theme data => $isDark");
    final theme = Theme.of(context).brightness;
    log("Context Theme data => ${theme == Theme.of(context).brightness}");
    return (theme == theme) ? colorRed : colorBlue;
  }

  static Color getBlueColor(context) {
    final theme = Theme.of(context).brightness;
    return (theme == theme) ? colorBlue : colorRed;
  }
  //


  static const Color physicalActivityScreenColor = Color(0xff00C4FA);
  static const Color dietaryIntakeScreenColor = Color(0xff028002);
  static const Color bodyMeasurementScreenColor = Color(0xfff9a81a);
  static const Color bloodPressureScreenColor = Color(0xfff47527);
  static const Color sleepScreenColor = Color(0xff9176b4);
  static const Color bloodGlucoseScreenColor = Color(0xffe6e7e7);
  static const Color medAssistScreenColor = Color(0xffea528e);
  static const Color heartRateScreenColor = Color(0xff8db600);
  static const Color bodyTemperatureScreenColor = Color(0xffFF3333);
  static const Color bloodOxygenScreenColor = Color(0xFFBDBDBD);
  //static const Color bloodOxygenScreenColor = Color(0xffd3d3d3);
  static const Color familyScreenColor = Color(0xffE2A4CA);
  static const Color myHealthScreenColor = Color(0xff2cb673);

  //
  static const Color colorRed = Color(0xFFFF0000);
  static const Color colorBlue = Color(0xFF057DCF);
  static const Color colorGrey = Color(0xFFA0A4A8);
  static const Color colorlightGrey = Color(0xFFBCC1C6);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorNero = Color(0xFF1F1F1F);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorHint = Color(0xFF52575C);
  static const Color searchBg = Color(0xFFF4F7FC);
  static const Color colorGreyWhite = Color(0xFFCACCCF);
  static const Color colorGray = Color(0xff6E6E6E);
  static const Color colorOxfordBlue = Color(0xff282F39);
  static const Color colorGainsB = Color(0xffE8E8E8);
  static const Color colorNigherRider = Color(0xff303030);
  static const Color backgroundColor = Color(0xffF4F7FC);
  static const Color colorGreyBunker = Color(0xff25282B);
  static const Color colorGreyChateau = Color(0xffA0A4A8);
  static const Color borderColor = Color(0xFFDCDCDC);
  static const Color disableColor = Color(0xFF979797);

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };
}
