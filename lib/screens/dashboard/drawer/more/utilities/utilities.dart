import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/http_cleint/app_config.dart';
import 'package:wehealth/screens/dashboard/drawer/more/utilities/devices_tutorial.dart';
import '../../../../../global/constants/images.dart';
import '../../../../../global/styles/text_styles.dart';
import '../../../../../global/widgets/ios_close_appbar.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({Key? key}) : super(key: key);

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Utilities",
      appBarColor: Colors.blue,

      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {},
              leading: Image.asset(Images.bluetoothicon),
              title: Text(
                "Reset Bluetooth",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {},
              leading: Image.asset(Images.syncdata),
              title: Text(
                "Sync Data from Server",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {},
              leading: Image.asset(Images.syncdata),
              title: Text(
                "Sync Data To Server",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {},
              leading: Image.asset(Images.retrievedatabase),
              title: Text(
                "Retrive Database",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {
                Get.to(() => const DevicesTutorialScreen());
              },
              leading: Image.asset(Images.tutorial),
              title: Text(
                "Devices Tutorial",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {},
              leading: Image.asset(Images.avatar),
              title: Text(
                "Avatar",
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              onTap: () {},
              leading: const Icon(Icons.miscellaneous_services_sharp),
              title: Text(
                "Domain",
                style: TextStyles.textGreyBoldStyle(),
              ),
              subtitle: Text(
                AppConfig.baseUrl,
                style: TextStyles.textGreyBoldStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
