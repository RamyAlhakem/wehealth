import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_oxygen_controller/blood_oxygen_controller.dart';
import 'package:wehealth/screens/dashboard/blood_oxygen/blood_oxygen_timeline.dart';
import 'package:wehealth/screens/dashboard/blood_oxygen/blood_oxygen_trends.dart';
import 'package:wehealth/screens/dashboard/blood_oxygen/bloodoxygen_dashboard.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class BloodOxygenDetialsScreen extends StatefulWidget {
  const BloodOxygenDetialsScreen({Key? key}) : super(key: key);

  @override
  State<BloodOxygenDetialsScreen> createState() =>
      _BloodOxygenDetialsScreenState();
}

class _BloodOxygenDetialsScreenState extends State<BloodOxygenDetialsScreen> {
@override
void initState() {
  super.initState();
 Get.find<BloodOxygenController>().fetchUserBloodOxygenData(); 
}


  final baseColor = Colors.amber.shade700;
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Blood Oxygen",
      appBarColor: baseColor,
      tabCount: 3,
      tabTitles: const [
        "Dashboard",
        "Trends",
        "Timelines",
      ],
      tabs: [
        const BloodOxygenDashboard(),
        BloodOxygenTrendsTab(),
        const BloodOxygenTimelineTab(),
      ],
    );
  }
}
