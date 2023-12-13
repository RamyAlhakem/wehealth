import 'package:get/get.dart';

class Translate extends Translations {
  final Map<String, Map<String, String>> languages;
  Translate({required this.languages});

  @override
  Map<String, Map<String, String>> get keys {
    return languages;
  }
}
