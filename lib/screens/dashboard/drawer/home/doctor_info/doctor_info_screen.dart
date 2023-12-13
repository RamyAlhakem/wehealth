import 'dart:math' as math show pi, min, cos, sin;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/doctor_controller/doctor_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/user_doctors_list_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/doctor_info/doctor_details_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({Key? key}) : super(key: key);

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  @override
  void initState() {
    super.initState();
    final controller = Get.put(DoctorController());
    controller.fetchUserDoctorList();
  }

  final Color pageColor = Colors.indigo.shade900;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      tabCount: 2,
      appBarColor: pageColor,
      title: "Doctor Info",
      tabTitles: const [
        "CHART",
        "LIST",
      ],
      tabs: const [
        DoctorInfoChartTab(),
        DoctorInfoListTab(),
      ],
    );
  }
}

class DoctorInfoChartTab extends StatefulWidget {
  const DoctorInfoChartTab({
    Key? key,
  }) : super(key: key);

  @override
  State<DoctorInfoChartTab> createState() => _DoctorInfoChartTabState();
}

class _DoctorInfoChartTabState extends State<DoctorInfoChartTab> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.indigo.shade900,
      child: LayoutBuilder(builder: (context, constraints) {
        final minDistance =
            math.min(constraints.maxHeight, constraints.maxWidth);
        return SizedBox(
          child: GetBuilder<DoctorController>(builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotatingDoctorsWidget(dimention: minDistance),
              ],
            );
          }),
        );
      }),
    );
  }
}

class RotatingDoctorsWidget extends StatefulWidget {
  const RotatingDoctorsWidget({Key? key, required this.dimention})
      : super(key: key);

  final double dimention;
  @override
  State<RotatingDoctorsWidget> createState() => _RotatingDoctorsWidgetState();
}

class _RotatingDoctorsWidgetState extends State<RotatingDoctorsWidget>
    with SingleTickerProviderStateMixin {
  double rotation = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorController>(builder: (controller) {
      return SizedBox.square(
        dimension: widget.dimention,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: widget.dimention,
            maxWidth: widget.dimention,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: GestureDetector(
              onScaleStart: (details) {
                rotation = 0;
              },
              onScaleUpdate: (details) {
                setState(() {
                  rotation = details.rotation;
                });
              },
              child: Transform.rotate(
                angle: ((math.pi / 2) * rotation),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.green,
                              border: Border.all(
                                color: Colors.white,
                                width: 8,
                              )),
                        ),
                      ),
                      for (MapEntry<int, UserDoctorModel> doctor
                          in controller.doctorsList?.asMap().entries.toList() ??
                              [])
                        DoctorAvatarWidget(
                          rotation: rotation,
                          degree: ((360 / controller.doctorsList!.length) *
                              doctor.key),
                          doctor: doctor.value,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class DoctorAvatarWidget extends StatelessWidget {
  const DoctorAvatarWidget({
    Key? key,
    required this.rotation,
    required this.degree,
    required this.doctor,
  }) : super(key: key);

  final double rotation;
  final double degree;
  final UserDoctorModel doctor;

  double deg2rad(double deg) => deg * math.pi / 180;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        math.cos(deg2rad(degree)),
        math.sin(deg2rad(degree)),
      ),
      child: Transform.rotate(
        angle: -((math.pi / 2) * rotation),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.person,
              size: 32,
              color: Colors.white,
            ),
            const SizedBox(height: 6),
            Text(
              doctor.firstName ?? "",
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorInfoListTile extends StatelessWidget {
  const DoctorInfoListTile({
    Key? key,
    required this.doctorData,
  }) : super(key: key);
  final UserDoctorModel doctorData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => DoctorDetailsScreen(
              doctorId: doctorData.professionalID ?? -1,
            ));
      },
      title: Text(
        "${doctorData.firstName ?? ""} ${doctorData.lastName ?? ""}",
        style: TextStyles.smallTextBoldStyle().copyWith(color: Colors.white),
      ),
      subtitle: Text(
        doctorData.email ?? "",
        style:
            TextStyles.extraSmallBoldTextStyle().copyWith(color: Colors.white),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            doctorData.statusString,
            maxLines: 2,
            textAlign: TextAlign.center,
            style:
                TextStyles.extraSmallTextStyle().copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            doctorData.gender ?? "",
            style:
                TextStyles.extraSmallTextStyle().copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class DoctorInfoListTab extends StatelessWidget {
  const DoctorInfoListTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.indigo.shade900,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Doctor Info",
              style: TextStyles.normalTextBoldStyle()
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: 5),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
            Expanded(
              child: GetBuilder<DoctorController>(builder: (controller) {
                return ListView.builder(
                  itemCount: controller.doctorsList?.length ?? 0,
                  itemBuilder: (context, index) => DoctorInfoListTile(
                    doctorData: controller.doctorsList![index],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
