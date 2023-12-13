import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/auth_controller/auth_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_textfield.dart';

import '../../notifications/notification_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPassCon = TextEditingController();
  final TextEditingController newPassCon = TextEditingController();
  final TextEditingController confirmPassCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerSide(),
      appBar: AppBar(
        title: const Text("Change Password"),
        //  automaticallyImplyLeading: !Platform.isIOS,
        // leading: Platform.isIOS  
        // ?  IconButton(onPressed: (){
        //   Get.back();
        //   }, icon: const Icon(Icons.close),) 
        // : null,
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              Get.to(() => const NotificationScreen());
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "You can change your password by adding your old and new password information!",
                    style: TextStyles.extraSmallTextStyle()
                        .copyWith(color: Colors.blue),
                  ),
                ),
                const Divider(),
                HorizontalTextField(
                  controller: oldPassCon,
                  title: "Old Password",
                  isPassword: true,
                ),
                const Divider(),
                HorizontalTextField(
                  controller: newPassCon,
                  title: "New Password",
                  isPassword: true,
                ),
                const Divider(),
                HorizontalTextField(
                  controller: confirmPassCon,
                  title: "Confirm Password",
                  isPassword: true,
                ),
                const Divider(),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        )),
                    onPressed: () async {
                      await Get.find<AuthController>().changePassword(
                          oldPassCon.text,
                          newPassCon.text,
                          confirmPassCon.text);
                    },
                    child: Text(
                      "Change Password".toUpperCase(),
                      style: TextStyles.smallTextBoldStyle()
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
