import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/blood_pressure_controller/blood_pressure_controller.dart';
import 'package:wehealth/screens/dashboard/blood_pressure/blood_pressure_timeline_tab.dart';
import 'package:wehealth/screens/dashboard/blood_pressure/blood_pressure_trends_tab.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';
import 'blood_pressure_dashboard.dart';

class BloodPressureDetailsScreen extends StatefulWidget {
  const BloodPressureDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BloodPressureDetailsScreen> createState() =>
      _BloodPressureDetailsScreenState();
}

class _BloodPressureDetailsScreenState
    extends State<BloodPressureDetailsScreen> {
@override
  void initState() {
    super.initState();
    Get.find<BloodPressureController>().fetchUserBloodPressureHistory();
  }


  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Blood Pressure",
      appBarColor: Colors.orange.shade700,
      tabCount: 3,
      tabTitles: const [
        "Dashboard",
        "Trends",
        "Timelines",
      ],
      tabs: [
        const BloodPressureDashboard(),
        BloodPressureTrendsTab(),
        const BloodPressureTimelineTab(),
      ],
    );
  }
}
