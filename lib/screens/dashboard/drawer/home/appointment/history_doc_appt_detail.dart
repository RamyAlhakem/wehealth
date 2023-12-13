import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/user_appt_list_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';
import '../../../notifications/notification_screen.dart';
import '../../drawer_items.dart';

class HistoryDoctorApptDetail extends StatefulWidget {
  const HistoryDoctorApptDetail({Key? key, required this.data}) : super(key: key);
  final UserApptModel data;
  @override
  State<HistoryDoctorApptDetail> createState() => _HistoryDoctorApptDetailState();
}

class _HistoryDoctorApptDetailState extends State<HistoryDoctorApptDetail> {
  @override
  Widget build(BuildContext context) {
    final finalDateString =DateFormat("dd-MM-yyyy")
        .format(DateFormat("yyyy-MM-dd").parse(widget.data.appointmentDate!));
    return Scaffold(
      drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      appBar: AppBar(
        title: const Text("Booked Appointment"),
        backgroundColor: Colors.orange.shade700,
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
                    )),
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
                      finalDateString,
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
                    child: Text(
                      widget.data.appointmentTime ?? "",
                      style: TextStyles.smallTextStyle(),
                    )),
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
                      style: TextStyles.smallTextStyle().copyWith(color: Colors.grey),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
