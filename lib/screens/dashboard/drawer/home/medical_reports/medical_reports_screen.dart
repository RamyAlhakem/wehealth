import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/medical_report_controller/medical_report_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/screens/dashboard/drawer/home/medical_reports/add_lab_report.dart';
import 'package:wehealth/screens/dashboard/drawer/home/medical_reports/add_medical_report.dart';
import 'package:wehealth/screens/dashboard/drawer/home/medical_reports/medical_history_tab.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class MedicalReportsScreen extends StatefulWidget {
  const MedicalReportsScreen({Key? key}) : super(key: key);

  @override
  State<MedicalReportsScreen> createState() => _MedicalReportsScreenState();
}

class _MedicalReportsScreenState extends State<MedicalReportsScreen> {
  Color pageColor = Colors.deepPurpleAccent;

  @override
  void initState() {
    super.initState();
    Get.find<MedicalReportController>().fetchLabReports();
    Get.find<MedicalReportController>().fetchMedicalReports();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Medical Report",
      appBarColor: pageColor,
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          backgroundColor: pageColor,
          onPressed: () {
            if (DefaultTabController.of(context).index > 1) {
              Get.to(() => const AddMedicalReportScreen());
            } else {
              Get.to(() => const AddLabReportScreen());
            }
          },
          child: const Icon(Icons.add),
        );
      }),
      tabCount: 3,
      tabTitles: const ["Medical History", "Lab Report", "Medical Report"],
      tabs: const [
        MedicalHistoryTab(),
        LabReportTab(),
        MedicalReportTab(),
      ],
    );
  }
}

class MedicalReportTab extends StatelessWidget {
  const MedicalReportTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalReportController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.medicalReports.length,
        itemBuilder: (context, index) {
          final data = controller.medicalReports[index];
          return MedicalReportListTile(
            date: data.date,
            name: data.reportname ?? "",
            onTap: () {
              Get.to(() => AddMedicalReportScreen(
                    medicalReport: data,
                  ));
            },
          );
        },
      );
    });
  }
}

class LabReportTab extends StatelessWidget {
  const LabReportTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalReportController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.labReports.length,
        itemBuilder: (context, index) {
          final data = controller.labReports[index];
          return MedicalReportListTile(
            date: data.date,
            name: data.reportname ?? "",
            onTap: () {
              Get.to(() => AddLabReportScreen(
                    reportData: data,
                  ));
            },
          );
        },
      );
    });
  }
}

class MedicalReportListTile extends StatelessWidget {
  const MedicalReportListTile({
    Key? key,
    required this.name,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.description_rounded,
            size: 40,
          ),
        ],
      ),
      title: Text(
        name,
        style: TextStyles.normalTextStyle(),
      ),
      subtitle: Text(
        dateFormat.format(date),
        style: TextStyles.normalTextStyle(),
      ),
      trailing: Text(
        "View Report",
        style: TextStyles.extraSmallTextStyle(),
      ),
    );
  }
}
