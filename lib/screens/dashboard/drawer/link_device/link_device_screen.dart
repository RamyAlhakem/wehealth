import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/user_devices_controller/user_devices_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/user_devices_model.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';
import 'package:wehealth/screens/dashboard/drawer/link_device/user_device_control_screen.dart';
import '../../notifications/notification_screen.dart';
import 'add_new_device_list.dart';
import 'ble/flutter_blue_main.dart';

class LinkDeviceScreen extends StatefulWidget {
  const LinkDeviceScreen({Key? key}) : super(key: key);

  @override
  State<LinkDeviceScreen> createState() => _LinkDeviceScreenState();
}

class _LinkDeviceScreenState extends State<LinkDeviceScreen> {
  BluetoothAdapterState _bluetoothState = BluetoothAdapterState.unknown;
  late StreamSubscription _streamadapterstate;
  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _streamadapterstate = FlutterBluePlus.state.listen((state) {
      // ignore: deprecated_member_use
      _bluetoothState = state;
      setState(() {});
    });
    Get.put(UserDevicesController()).getUserDevices();
  }

  @override
  Widget build(BuildContext context) {
    return _bluetoothState == BluetoothAdapterState.on
        ? Scaffold(
            drawer: const DrawerSide(),
            appBar: AppBar(
              title: const Text("Devices"),
              actions: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // Get.to(() => const FlutterBluePlusApp());
                  },
                  icon: const Icon(
                    Icons.bluetooth,
                    color: Colors.blue,
                  ),
                ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GetBuilder<UserDevicesController>(
                    builder: (controller) {
                      return controller.userDevices != null &&
                              controller.userDevices!.isNotEmpty
                          ? ListView.builder(
                              itemCount: controller.userDevices?.length ?? 0,
                              itemBuilder: (context, index) {
                                final item = controller.userDevices![index];
                                log(item.toJson().toString());
                                return ConnectedDeviceListTileWidget(
                                  deviceModel: item,
                                );
                              },
                            )
                          : const Center(
                              child:
                                  Text("You do not have any paired devices!"),
                            );
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                    onPressed: () {
                      Get.to(() => const AddNewDeviceScreen());
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Add New devices".toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            backgroundColor: Colors.lightBlue,
            appBar: AppBar(
              title: Text("Bluetooth Off"),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bluetooth_disabled,
                    size: 200,
                    color: Colors.white54,
                  ),
                  Text(
                    "Bluetooth is ${_bluetoothState.toString().substring(22)}",
                    style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.symmetric(horizontal: 80),
                          primary: Colors.blueAccent),
                      onPressed: () {
                        FlutterBluePlus.turnOn();
                      },
                      child: const Text(
                        "Turn On",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ))
                ],
              ),
            ),
          );
  }
}

class ConnectedDeviceListTileWidget extends StatelessWidget {
  const ConnectedDeviceListTileWidget({
    Key? key,
    required this.deviceModel,
  }) : super(key: key);
  final UserDeviceModel deviceModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      onTap: () {
        Get.to(() => UserDeviceControlScreen(deviceModel: deviceModel));
      },
      leading: SizedBox(
        width: 50,
        child: Image.asset(
          deviceModel.imageLink,
        ),
      ),
      title: Text(
        deviceModel.convertedName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyles.smallTextBoldStyle().copyWith(
          color: Colors.grey.shade800,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  deviceModel.devicename ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'monserrat',
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade800,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Text(
                deviceModel.devicestatus == 1 ? "Enabled" : "Disabled",
                style: TextStyles.extraSmallBoldTextStyle(),
              ),
            ],
          ),
          Text(
            deviceModel.deviceuuid ?? "",
            style: TextStyles.extraSmallBoldTextStyle(),
          ),
        ],
      ),
      trailing: Icon(
        Icons.lock,
        size: 32,
        color: Colors.grey.shade600,
      ),
    );
  }
}
