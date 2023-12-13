// ignore_for_file: avoid_print, prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wehealth/controller/auth_controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/constants/color_resources.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import '../../global/constants/app_constants.dart';
import '../../global/constants/images.dart';
import '../../global/styles/button_style.dart';
import '../../http_cleint/app_config.dart';
import 'forgot_password.dart';
import 'signup.dart';

class SigninScreen extends StatefulWidget {
  static const String id = "/signin";
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
// Native
  static const methodChannelJava = MethodChannel("testingJavaCode");

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _testJavaCode() async {
    String batteryLevel;
    try {
      final int result =
          await methodChannelJava.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  // Native

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isChecked = true;

  bool _hidepass = true;
  final _emailController = TextEditingController(); //azam@umchtech.com
  final _passwordController = TextEditingController(); //123456

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    StorageController storageController = StorageController.instance();
    Get.put(AuthController(prefs: storageController.prefs!));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GetBuilder<AuthController>(
                builder: (authController) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 15.w, right: 15.w),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 50.h),
                            Image.asset(Images.wehealthLogo, height: 100.h),
                            Image.asset(Images.wehealthTextLogo, height: 15.h),

                            SizedBox(height: 30.h),
                            //
                            TextFormField(
                              controller: _emailController,
                              textCapitalization: TextCapitalization.none,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: 'example@mail.com',
                                labelText: 'email_address'.tr,
                                prefixIcon: Image.asset(Images.emailIcon),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email can not be empty";
                                } else if (!value.contains("@") ||
                                    !value.contains(".")) {
                                  return "Enter a valid email address";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  print("typing email ===>>> $value");
                                });
                              },
                            ),
                            SizedBox(height: 10.h),

                            //
                            TextFormField(
                              textCapitalization: TextCapitalization.none,
                              autocorrect: false,
                              controller: _passwordController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                labelText: 'password'.tr,
                                hintText: '********',
                                prefixIcon: Image.asset(Images.passwordIcon),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _hidepass = !_hidepass;
                                      print(_hidepass);
                                    });
                                  },
                                  icon: Icon(_hidepass
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "password can not be empty";
                                }
                                return null;
                              },
                              obscureText: _hidepass,
                              onChanged: (value) {
                                setState(() {
                                  print("typing email ===>>> $value");
                                });
                              },
                            ),
                            SizedBox(height: 15.h),

                            //
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => ForgotPassword());
                                  },
                                  child: Text(
                                    "forgot_password".tr,
                                    style: TextStyle(
                                        color: Colors.blue.shade700,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),

                            //
                            SizedBox(
                              height: 40.h,
                              width: AppConstant(context).width,
                              child: ElevatedButton(
                                style: ButtonStyles.getBlueStyle(context),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await Get.showOverlay(
                                      loadingWidget: OverlayLoadingIndicator(),
                                      asyncFunction: () async {
                                        await authController.login(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            context: context);
                                      },
                                    );
                                  }

                                  print("Login Button....");
                                },
                                child: Text(
                                  "login".tr.toUpperCase(),
                                  style: TextStyles.extraSmallTextButtonStyle()
                                      .copyWith(
                                          color: ColorResources.colorWhite),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.h),

                            //
                            Text(
                              "dont_account_text".tr,
                              style: TextStyle(color: Colors.blue),
                            ),
                            SizedBox(height: 20),

                            //
                            SizedBox(
                              height: 40.h,
                              width: AppConstant(context).width,
                              child: OutlinedButton(
                                onPressed: () async {
                                  Get.to(() => SignUpScreen());
                                  // await _testJavaCode();
                                  // print(_batteryLevel);
                                },
                                child: Text(
                                  "create_account".tr,
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 3.h),
            if (Platform.isIOS)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('App Version : ${AppConfig.iOSAppVersion}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
