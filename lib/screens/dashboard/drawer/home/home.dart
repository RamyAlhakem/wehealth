import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wehealth/controller/profile_controller/profile_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/chart_data_model.dart';
import 'package:wehealth/screens/dashboard/body_measurements/body_measurement_home.dart';
import 'package:wehealth/screens/dashboard/body_measurements/body_measurements_screen.dart';
import 'package:wehealth/screens/dashboard/browser/global_browser.dart';
import 'package:wehealth/screens/dashboard/diet_intake/diet_intake_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appointment_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/home/care_plan/care_plan_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/home/challenges/challenges_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/home/doctor_info/doctor_info_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/home/fitness_assesment/fitness_assesment.dart';
import 'package:wehealth/screens/dashboard/drawer/home/fitness_workout/fitness_workout_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/home/medical_reports/medical_reports_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/home/social_activity/social_activity_screen.dart';
import 'package:wehealth/screens/dashboard/drawer/home/tele_consultation/tele_consultation_screen.dart';
import 'package:wehealth/screens/dashboard/family/next_of_kin.dart';
import 'package:wehealth/screens/dashboard/med_assist/med_assist_dashboard.dart';
import 'package:wehealth/screens/dashboard/physical_activity/physical_activity_screen.dart';
// import 'package:wehealth/screens/dashboard/sleep/sleep_screen.dart';
import 'package:wehealth/screens/dashboard/ummc_my_health/ummc_my_health_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/profile_incomplete_dialogue.dart';
import '../../notifications/notification_screen.dart';
import '../drawer_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isProfileComplete = false;
  @override
  void initState() {
    super.initState();
    final controller = Get.find<ProfileController>();
    controller.fetchHealthScore();
    _isProfileComplete = controller.isProfileComplete;
  }

  final List<ChartData> chartData = [
    ChartData('David', 25),
    ChartData('Steve', 38),
  ];

  List<Color> colors = [
    Colors.green,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    drawer: const DrawerSide(),
    appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              Get.to(() => const NotificationScreen());
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RegularHomeCardTile(
                        color: Colors.orangeAccent.shade200,
                        imgLink: "assets/icons/home/appointmenticon.webp",
                        onTap: () {
                          if (!_isProfileComplete) {
                            showProfileDialog(context);
                          } else {
                            Get.to(() => const AppointmentScreen());
                          }
                        },
                        title: "Appointments",
                      ),
                    ),
                    Expanded(
                      child: RegularHomeCardTile(
                        color: Colors.blue.shade200,
                        imgLink:
                            "assets/icons/home/telehealthconsultation.webp",
                        onTap: () {
                          Get.to(() => const TeleConsultationScreen());
                        },
                        title: "tele_consultration".tr,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RegularHomeCardTile(
                        color: Colors.indigo,
                        imgLink: "assets/icons/home/doctorinfo.webp",
                        onTap: () {
                          if (!_isProfileComplete) {
                            showProfileDialog(context);
                          } else {
                            Get.to(() => const DoctorInfoScreen());
                          }
                        },
                        title: "Doctor Info",
                      ),
                    ),
                    Expanded(
                      child: RegularHomeCardTile(
                        color: Colors.blueAccent,
                        imgLink: "assets/icons/home/ummc.png",
                        onTap: () {
                          Get.to(() => const MyHealthScreen());
                        },
                        title: "MyHealth",
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DataHomeCardTile(
                        color: Colors.blue,
                        onTap: () {
                          if (!_isProfileComplete) {
                            showProfileDialog(context);
                          } else {
                            Get.to(() => const PhysicalActivityScreen());
                          }
                        },
                        dataWidget: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.asset(
                            "assets/icons/home/1.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ) /* const CustomGauge(
                          start: 0,
                          end: 100,
                          needleValue: 50,
                          textColor: Colors.blue,
                          title: "Physical Activity",
                          knobColor: Colors.black,
                          gaugeRanges: [],
                        ) */
                        ,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: DataHomeCardTile(
                          color: Colors.orange.shade200,
                          dataWidget: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(
                              "assets/icons/home/2.png",
                              fit: BoxFit.fitWidth,
                            ),
                          ) /* CustomGauge(
                            start: 0,
                            end: 100,
                            needleValue: 50,
                            textColor: Colors.orange.shade200,
                            title: "Body Measurements",
                            knobColor: Colors.black,
                            gaugeRanges: const [],
                          ) */
                          ,
                          onTap: () {
                            if (!_isProfileComplete) {
                              showProfileDialog(context);
                            } else {                        
                              Get.to(() => const BodyMeasurementHome());
                            }
                            // ScrollSpringSimulation(spring, start, end, velocity)
                            // FrictionSimulation(drag, position, velocity)
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DataHomeCardTile(
                        color: Colors.deepPurple,
                        onTap: () {
                          // Get.to(() => const SleepScreen());
                        },
                        dataWidget: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.asset(
                            "assets/icons/home/4.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ) /* const CustomGauge(
                          start: 0,
                          end: 100,
                          needleValue: 50,
                          textColor: Colors.deepPurple,
                          title: "Sleep Quality",
                          knobColor: Colors.black,
                          gaugeRanges: [],
                        ) */
                        ,
                      ),
                    ),
                    Expanded(
                      child: DataHomeCardTile(
                        color: Colors.green.shade800,
                        onTap: () {
                          if (!_isProfileComplete) {
                            showProfileDialog(context);
                          } else {
                            Get.to(() => const DietIntakeScreen());
                          }
                        },
                        dataWidget: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.asset(
                            "assets/icons/home/3.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ) /* CustomGauge(
                          start: 0,
                          end: 100,
                          needleValue: 50,
                          textColor: Colors.green.shade800,
                          title: "Dietary Intake",
                          knobColor: Colors.black,
                          gaugeRanges: [],
                        ) */
                        ,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DataHomeCardTile(
                        color: Colors.pink,
                        dataWidget: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.asset(
                            "assets/icons/home/6.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ) /* const CustomGauge(
                          start: 0,
                          end: 100,
                          needleValue: 50,
                          textColor: Colors.pink,
                          title: "Med Assist",
                          knobColor: Colors.black,
                          gaugeRanges: [],
                        ) */
                        ,
                        onTap: () {
                          Get.to(() => const MedAssistDashboardScreen());
                        },
                      ),
                    ),
                    Expanded(
                      child: RegularHomeCardTile(
                        color: Colors.green,
                        imgLink: "assets/icons/home/careplanicon.webp",
                        onTap: () {
                          if (!_isProfileComplete) {
                            showProfileDialog(context);
                          } else {
                            Get.to(() => const CarePlanScreen());
                          }
                        },
                        title: "Care Plan",
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child:
                          GetBuilder<ProfileController>(builder: (controller) {
                        return DataHomeCardTile(
                          color: Colors.blue,
                          dataWidget: IgnorePointer(
                            ignoring: true,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: SfCircularChart(
                                    annotations: [
                                      CircularChartAnnotation(
                                        widget: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            '${controller.healthScoreData?.obtainedScore ?? 0}/${controller.healthScoreData?.totalScore ?? 0}',
                                            textAlign: TextAlign.center,
                                            style: TextStyles
                                                .extraSmallTextStyle(),
                                          ),
                                        ),
                                      ),
                                    ],
                                    series: <CircularSeries>[
                                      DoughnutSeries<ChartData, String>(
                                        radius: "100%",
                                        dataSource: <ChartData>[
                                          ChartData(
                                            "Obtained Score",
                                            double.tryParse(controller
                                                        .healthScoreData
                                                        ?.obtainedScore
                                                        .toString() ??
                                                    "0") ??
                                                0,
                                            Colors.green,
                                          ),
                                          ChartData(
                                              "Total Score",
                                              double.tryParse(controller
                                                          .healthScoreData
                                                          ?.totalScore
                                                          .toString() ??
                                                      "0") ??
                                                  0,
                                              Colors.blue),
                                        ],
                                        pointColorMapper: (ChartData data, _) =>
                                            data.color,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        name: "data",
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Health Score",
                                    style: TextStyles.customText(10.sp, FontWeight.w600)
                                        .copyWith(
                                            color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          )
                          /* CustomGauge(
                            start: 0,
                            end: 14,
                            needleValue: double.tryParse(controller
                                        .healthScoreData?.totalScore
                                        .toString() ??
                                    "") ??
                                0.00,
                            textColor: Colors.blue,
                            title: "Your Health Score",
                            knobColor: Colors.black,
                            gaugeRanges: [],
                          ) */
                          ,
                          onTap: () {
                            log(Get.find<StorageController>().email);
                            log(Get.find<StorageController>().password);
                            Get.to(
                              () => GlobalBrowser(
                                url:
                                    "https://www.umchtech.com/chief/checkloginApp.php?email=${Get.find<StorageController>().email}&password=${Get.find<StorageController>().password}",
                                onPageStarted: (url, controller) {},
                                onPageFinished: (url, controller) {
                                  log(url);
                                  String firstUrl =
                                      "https://www.umchtech.com/chief/portal/";
                                  String secondUrl =
                                      "https://www.umchtech.com/chief/portal/health-score.php";

                                  if (url == firstUrl) {
                                    log("It matched & moving!!");
                                    controller.loadUrl(secondUrl);
                                  }
                                },
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    Expanded(
                      child: RegularHomeCardTile(
                        color: Colors.purple,
                        imgLink: "assets/icons/home/medicalreport.webp",
                        onTap: () {
                          if (!_isProfileComplete) {
                            showProfileDialog(context);
                          } else {
                            Get.to(() => const MedicalReportsScreen());
                          }
                        },
                        title: "Medical Report",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RegularHomeCardTile(
                        color: Colors.pinkAccent.shade100,
                        imgLink: "assets/icons/home/familyicon.webp",
                        onTap: () {
                          if (!_isProfileComplete) {
                            showProfileDialog(context);
                          } else {
                            Get.to(() => const NextOfKinScreen());
                          }
                        },
                        title: "Family",
                      ),
                    ),
                    Expanded(
                      child: RegularHomeCardTile(
                        color: Colors.purple.shade200,
                        imgLink: "assets/icons/home/socialactivity_icon.webp",
                        onTap: () {
                          if (!_isProfileComplete) {
                            showProfileDialog(context);
                          } else {
                            Get.to(() => const SocialActivityScreen());
                          }
                        },
                        title: "Social Activity",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RegularHomeCardTile(
                        color: Colors.red,
                        imgLink: "assets/icons/home/mnu_fitness.webp",
                        onTap: () {
                          if (!_isProfileComplete) {
                            showProfileDialog(context);
                          } else {
                            Get.to(() => const FitnessAssesmentScreen());
                          }
                        },
                        title: "Fitness Assesments",
                      ),
                    ),
                    Expanded(
                      child: RegularHomeCardTile(
                        color: Colors.green,
                        imgLink: "assets/icons/home/fitnessicon.webp",
                        onTap: () {
                          Get.to(() => const FitnessWorkoutScreen());
                          //showToast("This feature is coming soon", context);
                        },
                        title: "Fitness Workout",
                      ),
                    )
                  ],
                ),
              ),
              /* GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: 16,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return const Card(
                    child: Center(
                      child: Text("data"),
                    ),
                  );
                },
              ), */
              RegularHomeCardTile(
                color: Colors.red,
                imgLink: "assets/icons/home/challenge1.png",
                onTap: () {
                  Get.to(() => const ChallengesScreen());
                },
                title: "Challenges",
                defaultColor: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RegularHomeCardTile extends StatelessWidget {
  const RegularHomeCardTile({
    Key? key,
    required this.color,
    required this.title,
    required this.imgLink,
    required this.onTap,
    this.defaultColor = true,
  }) : super(key: key);
  final Color color;
  final String title;
  final String imgLink;
  final bool defaultColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 1.5,
          color: color,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: color,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 125,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                    imgLink,
                    color: defaultColor ? color : null,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                    child: Row(
                    mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                           maxLines: 1,
                           overflow: TextOverflow.fade,
                          style: TextStyles.customText(11.sp, FontWeight.w600)
                              .copyWith(color: color ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataHomeCardTile extends StatelessWidget {
  const DataHomeCardTile({
    Key? key,
    required this.color,
    required this.dataWidget,
    required this.onTap,
  }) : super(key: key);
  final Color color;
  final Widget dataWidget;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 1.5,
          color: color,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: color,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 125,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: dataWidget,
              ),
              /* Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyles.extraSmallTextStyle().copyWith(color: color, fontWeight: FontWeight.w600),
                  ),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTileModel {
  final String title;
  final String imageLink;
  final VoidCallback onTap;
  final Color borderColor;
  final Color splashColor;

  const HomeTileModel(
      {required this.title,
      required this.imageLink,
      required this.onTap,
      required this.borderColor,
      required this.splashColor});
}
