import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/models/data_model/profile_model.dart';
import 'package:wehealth/screens/dashboard/drawer/change_password/change_password.dart';
import 'package:wehealth/screens/dashboard/drawer/card_management/card_management.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/link_device_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/profile/profile_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/questionnarie/questionnarie_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/user_goals.dart';
import '../../../global/constants/images.dart';
import '../../../global/methods/methods.dart';
import '../dashboard_screen.dart';
import 'home/home.dart';
import 'intelligent_alerts/intelligent_alarts.dart';
import 'more/more.dart';
import 'subscriptions/subscriptions.dart';

class DrawerSide extends StatelessWidget {
  const DrawerSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 140,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.drawerHeader),
                        fit: BoxFit.cover)),
                child: GetBuilder<ProfileController>(builder: (controller) {
                  UserProfile profile = controller.userProfile;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 15),
                          child: CircleAvatar(
                            maxRadius: 25,
                            foregroundImage: NetworkImage(
                                "https://www.umchtech.com/chief/portal/uploads/${profile.profilepic}"),
                            backgroundImage: AssetImage(
                                controller.userProfile.gender == "Male"
                                    ? "assets/images/male_profile.jpeg"
                                    : "assets/images/female_profile.jpeg"),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Text(
                              "${profile.firstName ?? ""} ${profile.lastName ?? ""}"),
                          subtitle: Text(
                            profile.email ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();
                Get.to(() => const DashboardScreen());
              }),
              leading: Image.asset(
                Images.dashboardIcon,
                height: 40,
              ),
              title: const Text("Dashboard"),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();

                Get.to(() => const HomeScreen());
              }),
              leading: Image.asset(Images.homeIcon, height: 30),
              title: const Text("Home"),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();

                Get.to(() => const SubcriptionScreen());
              }),
              leading: Image.asset(Images.subcriptionsIcon, height: 30),
              title: const Text("Subscriptions"),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();

                Get.to(() => const ProfileScreen());
                // Get.to(() => const ManualBloodPressureWidget());
              }),
              leading: Image.asset(Images.profileIcon, height: 30),
              title: const Text("Profile"),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();

                Get.to(() => const ChangePasswordScreen());
              }),
              leading: Image.asset(Images.changePasswordIcon, height: 30),
              title: const Text("Change Password"),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();

                Get.to(() => const UserGoalsScreen());
              }),
              leading: Image.asset(Images.userGoalIcon, height: 30),
              title: const Text("User Goal"),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();

                Get.to(() => const LinkDeviceScreen());
              }),
              leading: Image.asset(Images.linkDeviceIcon, height: 30),
              title: const Text("Link Device"),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();

                Get.to(() => const CardManagementScreen());
              }),
              leading: Image.asset(Images.cardManagementIcon, height: 30),
              title: const Text("Card Management"),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();

                Get.to(() => const IntelligentAlerts());
              }),
              leading: Image.asset(Images.inteligentIcon, height: 30),
              title: const Text("Intelligent Alerts"),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();

                Get.to(() => const QuestionnarieScreen());
              }),
              leading: Image.asset(Images.questionnarieIcon, height: 30),
              title: const Text("Questionnarie"),
            ),

            //
            ListTile(
              onTap: (() {
                Get.back();

                Get.to(() => const MoreScreen());
              }),
              leading: Image.asset(Images.moreIcon, height: 30),
              title: const Text("More"),
            ),

            //
            ListTile(
              onTap: () async {
                await onWillPopLogout(context);
                Get.find<StorageController>().prefs!.clear();
              },
              leading: Image.asset(Images.logoutIcon, height: 30),
              title: const Text("Logout"),
            ),
          ],
        )),
      ),
    );
  }
}
