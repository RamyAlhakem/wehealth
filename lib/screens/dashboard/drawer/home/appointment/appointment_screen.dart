import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/appt_controller/appt_controller.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/add_clinic_appt.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/add_doctor_appt.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/active_doc_appt_detail.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/edit_clinic_appt_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/all_caught_up_widget.dart';
import 'package:wehealth/screens/dashboard/widgets/appt_details_widget.dart';
import 'package:wehealth/screens/dashboard/widgets/scaffold_with_default_tab.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
bool isOpen = false;
  @override
  void initState() {
    super.initState();
    Get.find<ApptController>().fetchUserApptList();
    Get.find<ApptController>().fetchApptHospitalList();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDefaultTab(
      title: "Appointment",
      appBarColor: Colors.orange.shade700,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeChild: const Icon(Icons.close),
        backgroundColor: Colors.pinkAccent,
        closeManually: false,
        closeDialOnPop: true,
        renderOverlay: false,
        spacing: 12,
        spaceBetweenChildren: 12,
        onOpen: () async {
        setState(() {
          isOpen == true;
        });
         },
        children: [
          SpeedDialChild(
            child: const Icon(
              Icons.person_add_alt_rounded,
              color: Colors.white,
            ),
            backgroundColor: Colors.pinkAccent,
            label: 'Doctor Appointment', 
            labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            labelBackgroundColor: Colors.black87,
            onTap: () {
              Get.to(() => const AddDoctorAppointment());
            },
          ),
          SpeedDialChild(
              child: const Icon(
                Icons.medical_services_rounded,
                color: Colors.white,
              ),
              label: 'Clinic Appointment',
              labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              labelBackgroundColor: Colors.black87,
              backgroundColor: Colors.pinkAccent,
              onTap: () {
                Get.to(() => const AddClinicAppointment());
              }),
        ],
      ),
      tabCount: 2,
      tabTitles: const [
        "Active Appointments",
        "Appointment History",
      ],
      tabs: const [
        ActiveApptTab(),
        ApptHistoryTab(),
      ],
    );
  }
}

class ApptHistoryTab extends StatelessWidget {
  const ApptHistoryTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApptController>(builder: (apptController) {
      if ((apptController.userApptHistoryList != null &&
          apptController.userApptHistoryList!.isNotEmpty)) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: ListView.builder(
            itemCount: apptController.userApptHistoryList?.length,
            itemBuilder: (context, index) {
              final model = apptController.userApptHistoryList![index];
              return GestureDetector(
                  onTap: () {
                    /* if (model.hosApptID!.isNotEmpty && model.hosApptID != null) {                  
                        Get.to(() => EditClinicAppointment(
                            apptModel:
                                apptController.userApptHistoryList![index]));

                    log("hospital...");
                  } else {
                    Get.to(
                      () => HistoryDoctorApptDetail(
                        data: model,
                      ),
                    );
                    log("doctor...");
                  } */
                },
                child: ApptDetailTile(
                  data: model,
                ),
              );
            },
          ),
        );
      } else {
        return const AllCaughtUpWidget(
          endLine: "There are no new appointments.",
        );
      }
    });
  }
}

class ActiveApptTab extends StatelessWidget {
  const ActiveApptTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApptController>(builder: (apptController) {
      if ((apptController.userApptActiveList != null &&
          apptController.userApptActiveList!.isNotEmpty)) {
        return RefreshIndicator(
        onRefresh: (){
          return apptController.fetchUserApptList();
        },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: ListView.builder(
              itemCount: apptController.userApptActiveList?.length,
              itemBuilder: (context, index) {
                final model = apptController.userApptActiveList![index];
                return GestureDetector(
                    onTap: () {
                      if (model.hosApptID!.isNotEmpty && model.hosApptID != null) {                  
                        Get.to(() => EditClinicAppointment(
                            apptModel: model));
            
                        log("hospital...");
                      } else {
                        Get.to(() => ActiveDoctorApptDetail(
                            data: apptController.userApptActiveList![index]));
                        log("doctor...");
                      }
                    },
                    child: ApptDetailTile(data: model));
              },
            ),
          ),
        );
      } else {
        return const AllCaughtUpWidget(
          endLine: "There are no new appointments.",
        );
      }
    });
  }
}
