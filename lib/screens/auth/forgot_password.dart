// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller/auth_controller.dart';
import '../../global/constants/app_constants.dart';
import '../../global/constants/color_resources.dart';
import '../../global/constants/images.dart';
import '../../global/styles/button_style.dart';
import '../../global/styles/text_styles.dart';
import '../dashboard/widgets/overlay_loading_indicator.dart';
import 'signin.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Platform.isIOS
            ? AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                centerTitle: false,
              )
            : null,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),

                      //
                      Image.asset(Images.wehealthLogo, height: 120.h),
                      Image.asset(Images.wehealthTextLogo, height: 15.h),

                      SizedBox(height: 30.h),
                      Text(
                          "Enter your email address below and click on the forget password button to reset your password. We will email you a link to reset your password.".tr,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        SizedBox(height: 40.h),

                      //
                      TextFormField(
                        controller: _emailController,
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
                      SizedBox(height: 50.h),

                      //
                      SizedBox(
                        height: 45.h,
                        width: AppConstant(context).width,
                        child: ElevatedButton(
                          style: ButtonStyles.getBlueStyle(context),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              Get.showOverlay(
                                loadingWidget: const OverlayLoadingIndicator(),
                                asyncFunction: () async {
                                  await authController
                                      .forgotPassword(_emailController.text);
                                },
                              );
                            }
                            print("Forgot Password Button....");
                          },
                          child: Text(
                            "forget_password".tr.toUpperCase(),
                            style: TextStyles.extraSmallTextButtonStyle()
                                .copyWith(color: ColorResources.colorWhite),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
