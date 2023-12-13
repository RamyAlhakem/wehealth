// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/global/widgets/richtext.dart';
import 'package:wehealth/screens/auth/signin.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller/auth_controller.dart';
import '../../global/constants/app_constants.dart';
import '../../global/constants/color_resources.dart';
import '../../global/constants/images.dart';
import '../../global/styles/button_style.dart';
import '../../global/styles/text_styles.dart';
import '../dashboard/browser/global_browser.dart';
import '../dashboard/widgets/overlay_loading_indicator.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "/registrationScreen";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isCheckedTermsOfService = false;
  bool _isCheckedPrivacyPolicy = false;

  bool _hidepass = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Image.asset(Images.wehealthLogo, height: 100.h),
                Image.asset(Images.wehealthTextLogo, height: 15.h),

                SizedBox(height: 10.h),
                Text(
                  "create_new_account".tr,
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600),
                ),
                SizedBox(height: 30.h),

                //
                TextFormField(
                  controller: _emailController,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "email_address".tr,
                    hintText: "example@mail.com",
                    prefixIcon: Image.asset(Images.emailIcon),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email can not be empty!";
                    } else if (!value.contains("@") || !value.contains(".")) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      log("email======$value");
                    });
                  },
                ),
                SizedBox(height: 20.h),

                //
                TextFormField(
                  controller: _passwordController,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
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
                      icon: Icon(
                          _hidepass ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password can not be empty!";
                    }
                    return null;
                  },
                  obscureText: _hidepass,
                  onChanged: (value) {
                    setState(() {
                      log("typing email ===>>> $value");
                    });
                  },
                ),
                SizedBox(height: 10.h),

                //
                Row(
                  children: [
                    GetBuilder<AuthController>(
                      builder: (authController) => Checkbox(
                        value: _isCheckedTermsOfService,
                        onChanged: (value) {
                          setState(() {
                            _isCheckedTermsOfService =
                                !_isCheckedTermsOfService;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: CustomRichText(
                        titleText: "terms_of_services".tr,
                        optional: '',
                        description: "terms_of_services_2".tr,
                        onTap: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(
                              () => const GlobalBrowser(
                                  url:
                                      "https://umchtech.com/termsOfService.php"),
                            );
                          },
                      ),
                    ),
                  ],
                ),

                //
                Row(
                  children: [
                    GetBuilder<AuthController>(
                      builder: (authController) => Checkbox(
                        value: _isCheckedPrivacyPolicy,
                        onChanged: (value) {
                          setState(() {
                            _isCheckedPrivacyPolicy = !_isCheckedPrivacyPolicy;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: CustomRichText(
                        titleText: "privacy_policy_line1".tr,
                        description: "privacy_policy".tr,
                        optional: "privacy_policy_line2".tr,
                        onTap: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(
                              () => const GlobalBrowser(
                                  url:
                                      "https://umchtech.com/privacyPolicy.php"),
                            );
                          },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),

                //
                SizedBox(
                  height: 45.h,
                  width: AppConstant(context).width,
                  child: ElevatedButton(
                    style: ButtonStyles.getBlueStyle(context),
                    onPressed: () async {
                      if (_isCheckedTermsOfService == false ||
                          _isCheckedPrivacyPolicy == false) {
                        showToast(
                            "Please accpet our Terms of Service & Provacy Policy",
                            context);
                      } else {
                        if (formKey.currentState!.validate()) {
                          Get.showOverlay(
                            loadingWidget: const OverlayLoadingIndicator(),
                            asyncFunction: () async {
                              await Get.find<AuthController>().register(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context);
                            },
                          );
                        } else {
                          print(" Button Pressed without validating....");
                        }
                      }
                      print("Just Button Pressed....");
                    },
                    child: Text(
                      "SIGN UP".tr.toUpperCase(),
                      style: TextStyles.extraSmallTextButtonStyle()
                          .copyWith(color: ColorResources.colorWhite),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),

                //
                if (Platform.isIOS)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account ? "),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SigninScreen());
                        },
                        child: Text(
                          "login_now".tr,
                          style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
