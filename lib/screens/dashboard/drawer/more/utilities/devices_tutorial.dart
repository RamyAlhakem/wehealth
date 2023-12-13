import 'dart:developer';
import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/dashboard_screen.dart';

class DevicesTutorialScreen extends StatefulWidget {
  const DevicesTutorialScreen({Key? key}) : super(key: key);

  @override
  State<DevicesTutorialScreen> createState() => _DevicesTutorialScreenState();
}

class _DevicesTutorialScreenState extends State<DevicesTutorialScreen> {
  late PageController _controller;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Platform.isIOS
          ? FloatingActionButton(
              backgroundColor: const Color(0x00FFFFFF),
              child: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          //alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  _index = value;
                });
                log(value.toString());
              },
              children: [
                const FirstChiefPage(),
                const SecendProductPage(),
                const ProductPage(
                  color: Colors.cyan,
                  title: "CHIEF Walk Activity And Sleep Tracker (Wearable)",
                  desc:
                      "CHIEF Walk Activity And Sleep Tacker allows you to measure steps, calories, activities and sleeps quality",
                  imgPath: "assets/icons/devices/walktrackerslide2.webp",
                ),
                ProductPage(
                  color: Colors.deepPurpleAccent.shade400,
                  title: "CHIEF Star Activity And Sleep Tracker (Wearable)",
                  desc:
                      "CHIEF Star Activity And Sleep Tacker allows you to measure steps, calories, activities and sleeps quality",
                  imgPath: "assets/icons/startrackertutorial.webp",
                ),
                const ProductPage(
                  color: Colors.green,
                  title: "CHIEF Fit HR (Wearable)",
                  desc:
                      "CHIEF Fit HR is a premium tracker. It allows you to measure steps, calories, activities, heart rate and sleeps quality. It also helps you in reminding medicines and in keeping easy track of your notification and messages.",
                  imgPath: "assets/icons/devices/newtracker.webp",
                ),
                ProductPage(
                  color: Colors.pink.shade900,
                  title: "CHIEF Smart Body Analyzer (Weighing Scale)",
                  desc:
                      "CHIEF Smart Body Analyzer helps you to keep track of Body weight, BMI, Body Fat, Body Water, Bone Density, Visceral Fat,Muscle Mass, BMR. These parameters helps doctor and fitness trainer to keep track of your fitness.",
                  imgPath: "assets/icons/devices/bodyanalyzertut.webp",
                ),
                const ProductPage(
                  color: Colors.deepPurple,
                  title: "CHIEF Smart Bathroom Scale (Weighing Scale)",
                  desc:
                      "CHIEF Smart Bathroom Scale helps you to keep track of your Body Weight, BMI and BMR. These parameters helps you to keep track of your progress towards fitness",
                  imgPath: "assets/icons/devices/scale_200px.webp",
                ),
                const ProductPage(
                  color: Colors.blue,
                  title: "CHIEF Blood Pressure Scale",
                  desc:
                      "Blood pressure is the chronic disease which needs life time managment. CHIEF Blood Pressure Scale keeps track of your blood pressure and helps in early detection and managment of this chronic disease",
                  imgPath: "assets/icons/devices/bloodpressureslider.webp",
                ),
                const ProductPage(
                  color: Colors.cyan,
                  title: "CHIEF Nutritionist Scale",
                  desc:
                      "Diet plays a vital role in fitness and pervention of chronic disease.CHIEF Nutritionist scale helps you to measure your daily calories and fluid intake accurately",
                  imgPath: "assets/icons/devices/nutritionisticon.webp",
                ),
                ProductPage(
                  color: Colors.green.shade900,
                  title: "CHIEF Body Temperature Scale",
                  desc:
                      "CHIEF Body Temperature helps you analyze your body temperature. You can easily measure your body temperature and your temperature data will be than transfered to the mobile device",
                  imgPath: "assets/icons/devices/scale_200px.webp",
                ),
              ],
            ),
            SizedBox(
              height: 56,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                    top: BorderSide(
                      color: Colors.black54,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const DashboardScreen());
                        },
                        child: Center(
                          child: Text(
                            "SKIP",
                            style: TextStyles.smallTextStyle()
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: DotsIndicator(
                        dotsCount: 10,
                        decorator: const DotsDecorator(
                          spacing: EdgeInsets.all(3),
                          activeColor: Colors.white,
                          color: Colors.white30,
                        ),
                        position: _index.toDouble(),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox.expand(
                        child: (_index == 9)
                            ? InkWell(
                                onTap: () {
                                  Get.to(() => const DashboardScreen());
                                },
                                child: Center(
                                  child: Text(
                                    "DONE",
                                    style: TextStyles.smallTextStyle()
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  _controller.jumpToPage(_index + 1);
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({
    Key? key,
    required this.title,
    required this.desc,
    required this.imgPath,
    required this.color,
  }) : super(key: key);

  final String title;
  final String desc;
  final String imgPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyles.extraLargeTextStyle()
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SizedBox.expand(
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    imgPath,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: TextStyles.extraSmallTextStyle()
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecendProductPage extends StatelessWidget {
  const SecendProductPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade300,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                "Our Products",
                style:
                    TextStyles.largeTextStyle().copyWith(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "We have following products which keep tracks of your daily fitness",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  Text(
                    """
    1) CHIEF Walk Activity And Sleep Tracker
    2) CHIEF Star Activity And Sleep Tracker\n
    3) CHIEF Fit HR
    4) CHIEF Smart Body Analyzer\n
    5) CHIEF Smart Bathroom Scale
    6) CHIEF Blood Pressure Scale\n
    7) CHIEF Nutritionist Scale
    8) CHIEF Body Temperature Scale\n""",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FirstChiefPage extends StatelessWidget {
  const FirstChiefPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                "CHIEF",
                style: TextStyles.extraLargeTextStyle()
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Image.asset(
              "assets/icons/firstslide.webp",
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "UMCH Technology allows you to keep track of your and your family health information and store it online securely at our servers. You can track your weight, food intake, blood pressure, heart rate,oxygen concentration and sleep progress to help you stay on the path to fitness.\n\n\n",
                  textAlign: TextAlign.center,
                  style: TextStyles.extraSmallTextStyle()
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
