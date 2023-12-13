import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:wehealth/global/constants/app_constants.dart';
import 'package:wehealth/models/data_model/language_model.dart';

Future<Map<String, Map<String, String>>> languageinit() async {
// Retrieving localized data
  Map<String, Map<String, String>> _languages = {};
  for (LanguageModel languageModel in AppConstant.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/languages/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = {};
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;
}
