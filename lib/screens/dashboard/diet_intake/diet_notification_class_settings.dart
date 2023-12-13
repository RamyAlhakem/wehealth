import 'package:flutter/material.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';

class DietNotificationClassSettingScreen extends StatefulWidget {
  const DietNotificationClassSettingScreen({Key? key}) : super(key: key);

  @override
  State<DietNotificationClassSettingScreen> createState() =>
      _DietNotificationClassSettingScreenState();
}

class _DietNotificationClassSettingScreenState
    extends State<DietNotificationClassSettingScreen> {
  final pageColor = Colors.green.shade700;
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Intelligent Alerts",
      appBarColor: pageColor,
      body: Column(
        children: [
          SwitchListTile(
            value: isActive,
            isThreeLine: true,
            title: const Text("Diet"),
            activeColor: pageColor,
            subtitle: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Frequency: Every Day"),
                Text("Time: 14:00"),
              ],
            ),
            onChanged: (value) {
              setState(() {
                isActive = value;
              });
            },
          ),
          SwitchListTile(
            value: isActive,
            isThreeLine: true,
            title: const Text("Diet"),
            activeColor: pageColor,
            subtitle: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Frequency: Every Day"),
                Text("Time: 14:00"),
              ],
            ),
            onChanged: (value) {
              setState(() {
                isActive = value;
              });
            },
          ),
          SwitchListTile(
            value: isActive,
            isThreeLine: true,
            title: const Text("Diet"),
            activeColor: pageColor,
            subtitle: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Frequency: Every Day"),
                Text("Time: 14:00"),
              ],
            ),
            onChanged: (value) {
              setState(() {
                isActive = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
