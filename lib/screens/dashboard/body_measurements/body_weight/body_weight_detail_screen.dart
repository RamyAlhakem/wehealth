import 'package:flutter/material.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

import 'body_weight_dashboard_tab.dart';
import 'body_weight_timeline_tab.dart';
import 'body_weight_trends_tab.dart';

class BodyWeightDetailScreen extends StatefulWidget {
  const BodyWeightDetailScreen({Key? key}) : super(key: key);

  @override
  State<BodyWeightDetailScreen> createState() => _BodyWeightDetailScreenState();
}

class _BodyWeightDetailScreenState extends State<BodyWeightDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Get.find<HeartRateController>().fetchUserHeartRate();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Body Measurements",
      appBarColor: Colors.amber.shade600,
      tabCount: 3,
      tabTitles: const [
        "Dashboard",
        "Trends",
        "Timelines",
      ],
      tabs: [
        const BodyWeightDashboardTab(),
        BodyWeightTrendsTab(),
        const BodyWeightTimelineTab(),
      ],
    );
  }
}
