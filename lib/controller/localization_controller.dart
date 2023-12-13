import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/constants/app_constants.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences prefs;

  LocalizationController({required this.prefs}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstant.languages[0].languageCode!,
      AppConstant.languages[0].countryCode);
  bool _isLtr = true;
  Locale get locale => _locale;
  bool get isLtr => _isLtr;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    saveLanguage(_locale);
    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
        prefs.getString(AppConstant.languageCode) ??
            AppConstant.languages[0].languageCode!,
        prefs.getString(AppConstant.countryCode) ??
            AppConstant.languages[0].countryCode);
    _isLtr = _locale.languageCode != 'ar';
    update();
  }

  void saveLanguage(Locale locale) async {
    prefs.setString(AppConstant.languageCode, locale.languageCode);
    prefs.setString(AppConstant.countryCode, locale.countryCode!);
  }
}
