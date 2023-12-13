// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:wehealth/screens/auth/signin.dart';
import 'package:get/get.dart';
import '../controller/theme_controller.dart';
import '../global/styles/button_style.dart';
import '../localization/choose_language_screen.dart';

class AppMainSettings extends StatefulWidget {
  static const String id = "AppMainSettings";
  const AppMainSettings({Key? key}) : super(key: key);

  @override
  State<AppMainSettings> createState() => _AppMainSettingsState();
}

class _AppMainSettingsState extends State<AppMainSettings> {
  @override
  Widget build(BuildContext context) {
    final ThemeController _themeController = Get.put(ThemeController());
    print("theme data in main settings....");
    print(_themeController.themeValue);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Change Theme"),
              trailing: Tooltip(
                message: "Theme Mode",
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFDB84),
                  fontFamily: "Montserrat",
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _themeController.toggleTheme();
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFDB84),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: _themeController.themeValue
                        ? const Icon(
                            Icons.dark_mode,
                            size: 20,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.light_mode,
                            size: 20,
                            color: Colors.black,
                          ),
                  ),
                ),
              ),
            ),

            ListTile(
                leading: const Icon(Icons.settings),
                title: Text("choose_the_language".tr),
                trailing: IconButton(
                    onPressed: () {
                      Get.to(() => ChooseLanguageScreen());
                    },
                    icon: Icon(Icons.arrow_forward_ios))),

            ElevatedButton(
              onPressed: () {
                // Get.to(()=>DemoScreen());
              },
              child: Text("Go next"),
              style: ButtonStyles.getThemeStyle(context),
            ),

            ElevatedButton(
                style: ButtonStyles.getThemeStyle(context),
                onPressed: () {
                  Get.to(() => SigninScreen());
                },
                child: Text("login".tr.toUpperCase())),
          ],
        ),
      ),
    );
  }
}
