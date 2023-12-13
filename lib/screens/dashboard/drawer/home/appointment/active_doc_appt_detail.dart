import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/appt_controller/appt_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/user_appt_list_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/edit_doctor_appt_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import '../../../notifications/notification_screen.dart';
import '../../drawer_items.dart';

class ActiveDoctorApptDetail extends StatefulWidget {
  const ActiveDoctorApptDetail({Key? key, required this.data})
      : super(key: key);
  final UserApptModel data;
  @override
  State<ActiveDoctorApptDetail> createState() => _ActiveDoctorApptDetailState();
}

class _ActiveDoctorApptDetailState extends State<ActiveDoctorApptDetail> {
  DateFormat stringDateWithTZ = DateFormat("yyyy-MM-ddTHH:mm:ss.S");

  @override
  Widget build(BuildContext context) {
    final finalDateString = DateFormat("dd-MM-yyyy")
        .format(stringDateWithTZ.parse(widget.data.appointmentDate ?? ""));
    return Scaffold(
      drawer: Platform.isAndroid ? const DrawerSide() : null,
      appBar: AppBar(
        title: const Text("Booked Appointment"),
        backgroundColor: Colors.orange.shade700,
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              Get.to(
                () => const NotificationScreen(),
              );
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Doctor",
                    style: TextStyles.smallTextBoldStyle()
                        .copyWith(color: Colors.amberAccent.shade700),
                  ),
                ),
                const Text(
                  ":",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 14),
                Expanded(
                    flex: 5,
                    child: Text(
                      widget.data.deptName ??
                          widget.data.doctorfirstName ??
                          "No Header!",
                      style: TextStyles.smallTextStyle(),
                    )),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text(
                      "Time",
                      style: TextStyles.smallTextBoldStyle()
                          .copyWith(color: Colors.amberAccent.shade700),
                    )),
                const Text(
                  ":",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 14),
                Expanded(
                    flex: 5,
                    child: Text(
                      finalDateString.toString(),
                      style: TextStyles.smallTextStyle(),
                    )),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text(
                      "Appt Type",
                      style: TextStyles.extraSmallText14BStyle()
                          .copyWith(color: Colors.amberAccent.shade700),
                    )),
                const Text(
                  ":",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 14),
                Expanded(
                    flex: 5,
                    child: Text(
                      apptTypeToString(widget.data.appointmentType),
                      style: TextStyles.extraSmallText14BStyle(),
                    )),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text(
                      "Appt Time",
                      style: TextStyles.smallTextBoldStyle()
                          .copyWith(color: Colors.amberAccent.shade700),
                    )),
                const Text(
                  ":",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 14),
                Expanded(
                    flex: 5,
                    child: 
                    Text(widget.data.appointmentTime ?? "",
                    //"${aptSlot.fromTime}-${aptSlot.toTime}",
                      style: TextStyles.smallTextStyle(),
                    ),
                    ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 4,
                    child: Text(
                      "Notes",
                      style: TextStyles.smallTextBoldStyle()
                          .copyWith(color: Colors.amberAccent.shade700),
                    )),
                const Text(
                  ":",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 14),
                Expanded(
                    flex: 5,
                    child: Text(
                      (widget.data.note != null && widget.data.note!.isNotEmpty)
                          ? widget.data.note!
                          : "No Notes",
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyles.smallTextStyle()
                          .copyWith(color: Colors.grey),
                    )),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.orange.shade700,
                        ),
                        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange.shade700,
                      ),
                      onPressed: () async {
                        Get.off(() => EditDoctorAppointment(doctorAppt: widget.data));
                      },
                      child: const Text(
                        "RESCHEDULE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.orange.shade700,
                        ),
                        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange.shade700,
                      ),
                      onPressed: () async {
                        await Get.showOverlay(
                        loadingWidget: const OverlayLoadingIndicator(),
                          asyncFunction: () async =>
                              await Get.find<ApptController>()
                                  .reqApptCancel(widget.data.id!),
                        );
                      },
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
    );
  }
}
