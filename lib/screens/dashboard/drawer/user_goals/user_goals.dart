import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/blood_glucose_goal.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/blood_oxygen_goal.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/blood_pressure_goal.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/body_temp_goal.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/brain_goal.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/calories_goal.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/exercise_goal.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/heart_goal.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/sleep_goal.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/steps_goal.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/water_intake.dart';
import 'package:wehealth/screens/dashboard/drawer/user_goals/weight_screen.dart';

import '../../notifications/notification_screen.dart';

class UserGoalsScreen extends StatefulWidget {
  const UserGoalsScreen({Key? key}) : super(key: key);

  @override
  State<UserGoalsScreen> createState() => _UserGoalsScreenState();
}

class _UserGoalsScreenState extends State<UserGoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Goal"),
        //  automaticallyImplyLeading: !Platform.isIOS,
        // leading: Platform.isIOS  
        // ?  IconButton(onPressed: (){
        //   Get.back();
        //   }, icon: const Icon(Icons.close),) 
        // : null,
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
            Get.to(() => const NotificationScreen());
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      drawer:  const DrawerSide(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GoalListTile(
              title: "Weight",
              data: "50",
              onTap: () {
                Get.to(() => const WeightGoalScreen());
              },
              unit: " kg",
              iconLink: "assets/images/goal_icons_2.png",
            ),
            GoalListTile(
              title: "Calories Intake",
              data: "0",
              onTap: () {
                Get.to(() => const CaloriesGoalScreen());
              },
              unit: " kcal/day",
              iconLink: "assets/images/goal_icons_8.png",
            ),
            GoalListTile(
              title: "Water Intake",
              data: "50",
              onTap: () {
                Get.to(() => const WaterIntakeScreen());
              },
              unit: " ml/day",
              iconLink: "assets/images/goal_icons.webp",
            ),
            GoalListTile(
              title: "Steps",
              data: "50",
              onTap: () {
                Get.to(() => const StepsGoalScreen());
              },
              unit: " steps/day",
              iconLink: "assets/images/goal_icons.png",
            ),
            GoalListTile(
              title: "Exercise/Activity",
              data: "50",
              onTap: () {
                Get.to(() => const ExerciseGoalScreen());
              },
              unit: " minutes/day",
              iconLink: "assets/images/goal_icons_3.png",
            ),
            GoalListTile(
              title: "Sleep Hours",
              data: "50",
              onTap: () {
                Get.to(() => const SleepGoalScreen());
              },
              unit: " minutes/day",
              iconLink: "assets/images/goal_icons_11.png",
            ),
            GoalListTile(
              title: "Brain Activity/day",
              data: "50",
              onTap: () {
                Get.to(() => const BrainGoalScreen());
              },
              unit: " minutes/day",
              iconLink: "assets/images/goal_icons_7.png",
            ),
            GoalListTile(
              title: "Heart Rate",
              data: "50",
              onTap: () {
                Get.to(() => const HeartGoalScreen());
              },
              unit: " bpm",
              iconLink: "assets/images/goal_icons_9.png",
            ),
            GoalListTile(
              title: "Blood Pressure",
              data: "50",
              onTap: () {
                Get.to(() => const BloodPressureGoalScreen());
              },
              unit: " mmHg",
              iconLink: "assets/images/goal_icons_5.png",
            ),
            GoalListTile(
              title: "Oxygen Level",
              data: "50",
              onTap: () {
                Get.to(() => const BloodOxygenGoalScreen());
              },
              unit: "%",
              iconLink: "assets/images/goal_icons_10.png",
            ),
            GoalListTile(
              title: "Blood Glucose",
              data: "50",
              onTap: () {
                Get.to(() => const BloodGlucoseGoalScreen());
              },
              unit: " mmol/L",
              iconLink: "assets/images/goal_icons_4.png",
            ),
            GoalListTile(
              title: "Body Temperature",
              data: "50",
              onTap: () {
                Get.to(() => const BodyTempGoalScreen());
              },
              unit: " C",
              iconLink: "assets/images/goal_icons_6.png",
            ),
          ],
        ),
      ),
    );
  }
}

class GoalListTile extends StatelessWidget {
  const GoalListTile({
    Key? key,
    required this.title,
    required this.data,
    required this.unit,
    required this.iconLink,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String data;
  final VoidCallback onTap;
  final String unit;
  final String iconLink;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 0.5,
        ),
      ),
      horizontalTitleGap: 8,
      leading: SizedBox(
        width: 32,
        child: Image.asset(
          iconLink,
          color: const Color.fromARGB(255, 73, 158, 255),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Text(
          title,
          style: TextStyles.extraSmallTextStyle(),
        ),
      ),
      subtitle: Text(
        data + unit,
        style: TextStyles.normalTextStyle(),
      ),
    );
  }
}
