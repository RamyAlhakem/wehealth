import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/user_devices_controller/user_devices_controller.dart';
import 'package:wehealth/controller/google_fit_controller/google_fit_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/models/data_model/user_devices_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/google_fit_setting_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import '../../../../global/methods/methods.dart';

class UserDeviceControlScreen extends StatelessWidget {
  const UserDeviceControlScreen({Key? key, required this.deviceModel})
      : super(key: key);
  final UserDeviceModel deviceModel;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Devices",
      appBarColor: Colors.blue,
      body: Column(
        children: [
          SizedBox(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(children: [
                Expanded(
                  flex: 3,
                  child: Image.asset(deviceModel.imageLink),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        deviceModel.convertedName,
                        style: TextStyles.largeTextBoldStyle(),
                      ),
                      Text(
                        deviceModel.deviceuuid ?? "",
                        style: TextStyles.extraSmallBoldTextStyle().copyWith(
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Last Pairing Date",
            style: TextStyles.extraLargeTextBoldStyle().copyWith(
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            DateFormat("d MMMM y, h:mm a").format(
              stringDateWithTZ.parse(deviceModel.insertionDateTime ?? ""),
            ),
            style: TextStyles.normalTextBoldStyle().copyWith(
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          ...getControlWidgets(deviceModel.devicebletype ?? "0"),
        ],
      ),
    );
  }

  List<Widget> getControlWidgets(String deviceId) {
    if (Platform.isIOS) {
      if (deviceId == "40") {
        return [
          TileButton(
            onPress: () async {
              final controller = Get.put(GoogleFitController());
              final res = await controller.requestNeededPermissions();
              // controller.getGoogleFitDailyData(); // calling sync
              // controller.fetchMonthlyData(); // calling sync
              log(res.toString());
            },
            title: "Sync Data",
            icon: Icons.sync,
          ),
        TileButton(
            onPress: () {
              //Get.to(() => const GoogleFitSettingScreen());
            },
            title: "Device Settings",
            icon: Icons.settings,
          ),
          TileButton(
            onPress: () async {
              bool res = await Get.showOverlay<bool>(
                loadingWidget: const OverlayLoadingIndicator(),
                asyncFunction: () async => await Get.find<UserDevicesController>()
                    .deleteUserDevices(deviceModel),
              );
              if (res) {
                log("Calling back!");
                Get.back(closeOverlays: true);
                Get.snackbar(
                  "Deleted!",
                  "Your device has been removed!",
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                );
              }
            },
            title: "Remove Device",
            icon: Icons.cancel,
          ),
        ];
      }
    }
    if (Platform.isAndroid) {
      if (deviceId == "30") {
        return [
          TileButton(
            onPress: () async {
              if(Platform.isAndroid){
                final controller = Get.put(GoogleFitController());
                final res = await controller.requestNeededPermissions();
                // controller.getGoogleFitDailyData();
                // controller.fetchMonthlyData();
                log(res.toString());
              }else{
                showToastWithout("Sync allows in android device only!");
              }
            },
            title: "Sync Data",
            icon: Icons.sync,
          ),
          TileButton(
            onPress: () {
              Get.to(() => const GoogleFitSettingScreen());
            },
            title: "Device Settings",
            icon: Icons.settings,
          ),
          TileButton(
            onPress: () async {
              bool res = await Get.showOverlay<bool>(
                loadingWidget: const OverlayLoadingIndicator(),
                asyncFunction: () async =>
                    await Get.find<UserDevicesController>()
                        .deleteUserDevices(deviceModel),
              );
              if (res) {
                log("Calling back!");
                Get.back(closeOverlays: true);
                Get.snackbar(
                  "Deleted!",
                  "Your device has been removed!",
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                );
              }
            },
            title: "Remove Device",
            icon: Icons.cancel,
          ),
        ];
      }
    }
    return [
      TileButton(
        onPress: () {
          //
        },
        title: "Enable Group Reading",
        icon: Icons.group,
      ),
      TileButton(
        onPress: () async {
          bool res = await Get.showOverlay<bool>(
            loadingWidget: const OverlayLoadingIndicator(),
            asyncFunction: () async => await Get.find<UserDevicesController>()
                .deleteUserDevices(deviceModel),
          );
          if (res) {
            log("Calling back!");
            Get.back(closeOverlays: true);
            Get.snackbar(
              "Deleted!",
              "Your device has been removed!",
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            );
          }
        },
        title: "Remove Device",
        icon: Icons.cancel,
      ),
    ];
  }
}

class TileButton extends StatelessWidget {
  const TileButton({
    Key? key,
    required this.onPress,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final VoidCallback onPress;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        ListTile(
          minVerticalPadding: 16,
          onTap: onPress,
          leading: Icon(
            icon,
            size: 40,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: TextStyles.smallTextBoldStyle(),
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
        ),
      ],
    );
  }
}
