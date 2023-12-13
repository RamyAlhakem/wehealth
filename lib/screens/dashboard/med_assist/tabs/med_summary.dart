import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/screens/dashboard/med_assist/med_assist_dashboard.dart';


class MedAssistSummaryTab extends StatelessWidget {
  const MedAssistSummaryTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: const Column(
            children: [
              Expanded(
                child: DayPortionWidget(
                  title: "Morning",
                  startTime: TimeOfDay(hour: 6, minute: 00),
                  endTime: TimeOfDay(hour: 11, minute: 59),
                  logoPath: "assets/images/ic_morning.png",
                ),
              ),
              Expanded(
                child: DayPortionWidget(
                  title: "Noon",
                  startTime: TimeOfDay(hour: 12, minute: 00),
                  endTime: TimeOfDay(hour: 15, minute: 59),
                  logoPath: "assets/images/ic_noon.png",
                ),
              ),
              Expanded(
                child: DayPortionWidget(
                  title: "Evening",
                  startTime: TimeOfDay(hour: 16, minute: 00),
                  endTime: TimeOfDay(hour: 18, minute: 59),
                  logoPath: "assets/images/ic_evening.webp",
                ),
              ),
              Expanded(
                child: DayPortionWidget(
                  title: "Night",
                  startTime: TimeOfDay(hour: 19, minute: 00),
                  endTime: TimeOfDay(hour: 05, minute: 59),
                  logoPath: "assets/images/ic_night.png",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DayPortionWidget extends StatelessWidget {
  const DayPortionWidget({
    Key? key,
    required this.title,
    required this.logoPath,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  final String title;
  final String logoPath;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => DayPortionMedicineScreen(
            title: title,
            endTime: endTime,
            startTime: startTime,
          ),
        );
      },
      child: ColoredBox(
        color:
            // (title == dayPortionToString(TimeOfDay.now())) ?
            TimeOfDay.now().inInclusiveRange(startTime, endTime)
                ? Colors.blueAccent.shade100.withOpacity(0.8)
                : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              SizedBox.square(
                dimension: 32,
                child: Image.asset(logoPath),
              ),
              const SizedBox(width: 12),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
