import 'package:flutter/material.dart';
import 'package:wehealth/screens/dashboard/blood_glucose/blood_glucose_trends.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

import 'blood_glucose_dashboard.dart';
import 'blood_glucose_timeline.dart';

class BloodGlucoseDetialsScreen extends StatefulWidget {
  const BloodGlucoseDetialsScreen({Key? key}) : super(key: key);

  @override
  State<BloodGlucoseDetialsScreen> createState() =>
      BloodGlucoseDetialsScreenState();
}

class BloodGlucoseDetialsScreenState extends State<BloodGlucoseDetialsScreen> {
  final baseColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      tabCount: 3,
      appBarColor: baseColor,
      title: "Blood Glucose",
      tabTitles: const [
        "Dashboard",
        "Trends",
        "Timelines",
      ],
      tabs: [
        const BloodGlucoseDashboardTab(),
        BloodGlucoseTrendsTab(),
        const BloodGlucoseTimelineTab(),
      ],
    );
  }
}
