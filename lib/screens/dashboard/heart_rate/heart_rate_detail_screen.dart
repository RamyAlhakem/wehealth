import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/heart_rate_controller/heart_rate_controller.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

import 'heartrate_dashboard_tab.dart';
import 'heartrate_timeline_tab.dart';
import 'heartrate_trends_tab.dart';

class HeartRateDetailScreen extends StatefulWidget {
  const HeartRateDetailScreen({Key? key}) : super(key: key);

  @override
  State<HeartRateDetailScreen> createState() => _HeartRateDetailScreenState();
}

class _HeartRateDetailScreenState extends State<HeartRateDetailScreen> {


  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Heart Rate",
      appBarColor: Colors.amber.shade600,
      tabCount: 3,
      tabTitles: const [
        "Dashboard",
        "Trends",
        "Timelines",
      ],
      tabs: [
        const HeartRateDashboardTab(),
        HeartRateTrendsTab(),
        const HeartRateTimelineTab(),
      ],
    );
  }
}
