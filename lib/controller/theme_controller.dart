import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController implements GetxService {
  SharedPreferences? prefs;
  ThemeController({this.prefs});

  @override
  onInit() async {
    super.onInit();
    _loadCurrentTheme();
    update();
  }

  bool _darkTheme = false;
  bool get themeValue => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    prefs!.setBool("theme", _darkTheme);
    update();
  }

  void _loadCurrentTheme() async {
    prefs = await SharedPreferences.getInstance();
    _darkTheme = prefs!.getBool("theme") ?? false;
    update();
  }
}
