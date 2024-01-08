import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wehealth/controller/auth_controller/auth_controller.dart';
import 'package:wehealth/screens/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/ble/HistoryController.dart';
import 'controller/localization_controller.dart';
import 'controller/theme_controller.dart';
import 'getit_locator.dart' as getit_locator;
import 'global/constants/app_constants.dart';
import 'global/routes/routes.dart';
import 'helper/translator_helper.dart';
import 'localization/translate.dart';
import 'screens/auth/signin.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';

Future<AndroidDeviceInfo?> initPlatformState() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      return info;
    }
  } on PlatformException {
    log("Error: Failed to get platform version.".toString());
  }
  return null;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final deviceInfo = await initPlatformState();

  await getit_locator.init(prefs, deviceInfo);
  Map<String, Map<String, String>> languages = await languageinit();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({Key? key, required this.languages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HistoryController(),
      child: ScreenUtilInit(
        //designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetBuilder<ThemeController>(
            builder: (themeController) {
              return GetBuilder<LocalizationController>(
                builder: (localizeController) {
                  return GetBuilder<AuthController>(builder: (authController) {
                    return GetMaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: 'WeHealth',
                      themeMode: ThemeMode.system,
                      theme: themeController.themeValue ? dark : light,
                      locale: localizeController.locale,
                      translations: Translate(languages: languages),
                      fallbackLocale: Locale(
                        AppConstant.languages[0].languageCode!,
                        AppConstant.languages[0].countryCode,
                      ),
                      routes: routes,
                      initialRoute:
                          (authController.prefs.containsKey('user_token'))
                              ? DashboardScreen.id
                              : SigninScreen.id,
                      home: child,
                    );
                  });
                },
              );
            },
          );
        },
        child: const SigninScreen(),
      ),
    );
  }
}
