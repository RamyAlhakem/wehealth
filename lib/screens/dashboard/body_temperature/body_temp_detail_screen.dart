import 'package:flutter/material.dart';
import 'package:wehealth/screens/dashboard/body_temperature/body_temp_dashboard.dart';
import 'package:wehealth/screens/dashboard/body_temperature/body_temp_timeline.dart';
import 'package:wehealth/screens/dashboard/body_temperature/body_temp_trends.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class BodyTempDetialsScreen extends StatefulWidget {
  const BodyTempDetialsScreen({Key? key}) : super(key: key);

  @override
  State<BodyTempDetialsScreen> createState() => BodyTempDetialsScreenState();
}

class BodyTempDetialsScreenState extends State<BodyTempDetialsScreen> {
  final pageColor = Colors.amber.shade600;
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      appBarColor: pageColor,
      tabCount: 3,
      title: "Body Temperature",
      tabTitles: const [
        "Dashboard",
        "Trends",
        "Timelines",
      ],
      tabs: [
        const BodyTempDashboard(),
        BodyTempTrendsTab(),
        const BodyTempTimelineTab(),
      ],
    );
  }
}
