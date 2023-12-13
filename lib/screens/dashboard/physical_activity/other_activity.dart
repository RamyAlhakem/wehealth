import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

import '../../../global/styles/text_styles.dart';
import '../widgets/image_tile_button.dart';

class OtherActivityTab extends StatelessWidget {
  const OtherActivityTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundImage:
                      AssetImage("assets/images/excercisetime_dashboard.webp"),
                  radius: 32),
              title: Text(
                "00:00 hh:mm 0 kcal",
                style: TextStyles.extraSmallText12BStyle()
                    .copyWith(color: Colors.blue.shade400),
              ),
              subtitle: Text(
                "Daily Exerscise Time: 30min",
                style: TextStyles.extraSmallDaysTextStyle()
                    .copyWith(color: Colors.blue.shade400),
              ),
            ),
            Text(
              "Exercise Activity",
              style: TextStyles.extraSmallTextStyle()
                  .copyWith(color: Colors.blue.shade400),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ImageTileButton(
                  image: "assets/images/sport_walking.webp",
                  title: "Walking",
                  onTap: () => Get.to(() => const ActivityMonitoringScreen()),
                ),
                ImageTileButton(
                    image: "assets/images/sport_running.webp",
                    onTap: () => Get.to(() => const ActivityMonitoringScreen()),
                    title: "Jogging"),
                ImageTileButton(
                    image: "assets/images/sport_mountain.webp",
                    onTap: () => Get.to(() => const ActivityMonitoringScreen()),
                    title: "climbing"),
                ImageTileButton(
                    image: "assets/images/sport_bicycle.webp",
                    onTap: () => Get.to(() => const ActivityMonitoringScreen()),
                    title: "Cycling"),
                ImageTileButton(
                    image: "assets/images/cyclinguphills.webp",
                    onTap: () => Get.to(() => const ActivityMonitoringScreen()),
                    title: "Cycling Up Hills"),
                ImageTileButton(
                    image: "assets/images/sport_yoga.webp",
                    onTap: () => newRecordUploadingFunc(context),
                    title: "Yoga"),
                ImageTileButton(
                    image: "assets/images/sport_warmup.webp",
                    onTap: () => newRecordUploadingFunc(context),
                    title: "Warmup"),
                ImageTileButton(
                    image: "assets/images/sport_dance.png",
                    onTap: () => newRecordUploadingFunc(context),
                    title: "Dancing"),
                ImageTileButton(
                  title: "Soccer",
                  image: "assets/images/sport_soccer.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Basketball",
                  image: "assets/images/sport_basket.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Volleyball",
                  image: "assets/images/sport_volleyball.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Pingpong",
                  image: "assets/images/sport_pingpong.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Badminton",
                  image: "assets/images/sport_badminton.png",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Tennis",
                  image: "assets/images/sport_tennis.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Swimming",
                  image: "assets/images/sport_swimming.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Boxing",
                  image: "assets/images/sport_boxing.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Martial Arts",
                  image: "assets/images/sport_martialarts.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Flexions",
                  image: "assets/images/sport_flexions.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Weight Lifting",
                  image: "assets/images/sport_weightlifting.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Ski",
                  image: "assets/images/sport_ski.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Gymnastics",
                  image: "assets/images/sport_gymnastics.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Bowling",
                  image: "assets/images/sport_bowling.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Squash",
                  image: "assets/images/squashicon.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
                ImageTileButton(
                  title: "Jumping Rope",
                  image: "assets/images/jumpingropeicon.webp",
                  onTap: () => newRecordUploadingFunc(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void newRecordUploadingFunc(BuildContext context) async {
    await showDialog(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return const NewRecordWidget();
      },
    );
  }
}

class ActivityMonitoringScreen extends StatefulWidget {
  const ActivityMonitoringScreen({Key? key}) : super(key: key);

  @override
  State<ActivityMonitoringScreen> createState() =>
      _ActivityMonitoringScreenState();
}

class _ActivityMonitoringScreenState extends State<ActivityMonitoringScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: 3,
      initialIndex: _index,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  const ScaffoldWithDefaultTab(
      title: "Exercise Activity",
      tabCount: 3,
      tabTitles: ["DASHBOARDY", "TRENDS", "TIMELINES"],
      tabs: [
        OngoingActivityTab(),
        ActivityTrendsTab(),
        ActivityTimelineTab(),
      ],
    );
   
  }
}

class ActivityTimelineTab extends StatelessWidget {
  const ActivityTimelineTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Record Found!"),
    );
  }
}

class ActivityTrendsTab extends StatelessWidget {
  const ActivityTrendsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: Center(
            child: Text("No Songs Found!"),
          ),
        ),
        SizedBox(
          height: 150,
          width: double.infinity,
          child: ColoredBox(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(5),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(5),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.play_arrow_rounded,
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(5),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "0.00",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: Slider(
                          label: "hellow.mp3",
                          max: 5.00,
                          min: 0.00,
                          value: 5,
                          activeColor: Colors.grey.shade300,
                          onChanged: (value) {},
                        ),
                      ),
                      const Text(
                        "5.00",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OngoingActivityTab extends StatelessWidget {
  const OngoingActivityTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: "0.00",
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: " km",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              DataOptionWidget(
                                icon: Icons.directions_run,
                                data: "0",
                                title: "RUNS",
                                unit: "",
                              ),
                              DataOptionWidget(
                                icon: Icons.speed_outlined,
                                data: "0.00",
                                title: "AVG SPEED",
                                unit: "km/h",
                              ),
                              DataOptionWidget(
                                icon: Icons.local_fire_department,
                                data: "0",
                                title: "CALORIES",
                                unit: "",
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        "Can't get weather information...",
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.network_wifi,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 70,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: SizedBox.expand(
                child: FittedBox(
                  child: Text(
                    "START GPS",
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DataOptionWidget extends StatelessWidget {
  const DataOptionWidget({
    Key? key,
    required this.title,
    required this.data,
    required this.unit,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String data;
  final String unit;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(width: 5.w),
            Text(
              "$data $unit",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text(
          title,
          style: TextStyle(
          fontSize: 10.sp,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class NewRecordWidget extends StatefulWidget {
  const NewRecordWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NewRecordWidget> createState() => _NewRecordWidgetState();
}

class _NewRecordWidgetState extends State<NewRecordWidget> {
  final _endTimeController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox.expand(
              child: Card(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ColoredBox(
                        color: Colors.blue,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: FittedBox(
                            child: Center(
                              child: Text(
                                "New Record",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Start Time",
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          TimeOfDay? time =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                              DateTime.now(),
                                            ),
                                          );
                                          if (time != null) {
                                            setState(() {
                                              _startTimeController.text =
                                                  time.format(context);
                                            });
                                          }
                                        },
                                        child: AbsorbPointer(
                                          absorbing: true,
                                          child: TextFormField(
                                            textCapitalization:
                                                TextCapitalization.none,
                                            controller: _startTimeController,
                                            decoration: decoration,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 4,
                                    child: Text(
                                      "End Time",
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          TimeOfDay? time =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(
                                              DateTime.now(),
                                            ),
                                          );
                                          if (time != null) {
                                            setState(() {
                                              _endTimeController.text =
                                                  time.format(context);
                                            });
                                          }
                                        },
                                        child: AbsorbPointer(
                                          absorbing: true,
                                          child: TextFormField(
                                            textCapitalization:
                                                TextCapitalization.none,
                                            controller: _endTimeController,
                                            decoration: decoration,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Record Date",
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          String date =
                                              await getSelectedDateString(
                                                  context);

                                          setState(() {
                                            _dateController.text = date;
                                          });
                                        },
                                        child: AbsorbPointer(
                                          absorbing: true,
                                          child: TextFormField(
                                            textCapitalization:
                                                TextCapitalization.none,
                                            controller: _dateController,
                                            decoration: decoration,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 0,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "SAVE",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
