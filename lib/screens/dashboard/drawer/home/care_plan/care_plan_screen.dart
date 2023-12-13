import 'package:flutter/material.dart';
import 'package:wehealth/screens/dashboard/widgets/all_caught_up_widget.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class CarePlanScreen extends StatefulWidget {
  const CarePlanScreen({Key? key}) : super(key: key);

  @override
  State<CarePlanScreen> createState() => _CarePlanScreenState();
}

class _CarePlanScreenState extends State<CarePlanScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      tabCount: 7,
      tabScrolled: true,
      title: "Care Plan",
      appBarColor: Colors.green,
      textColor: Colors.black,
      indicatorColor: Colors.black,
      selectedColor: Colors.red,
      tabBarBackgroudColor: Colors.grey.shade200,
      tabTitles: const [
        "SUN",
        "MON",
        "TUE",
        "WED",
        "THU",
        "FRI",
        "SAT",
      ],
      tabs: const [
        AllCaughtUpWidget(endLine: "There are no new task."),
        AllCaughtUpWidget(endLine: "There are no new task."),
        AllCaughtUpWidget(endLine: "There are no new task."),
        AllCaughtUpWidget(endLine: "There are no new task."),
        AllCaughtUpWidget(endLine: "There are no new task."),
        AllCaughtUpWidget(endLine: "There are no new task."),
        AllCaughtUpWidget(endLine: "There are no new task."),
      ],
    );
  }
}
