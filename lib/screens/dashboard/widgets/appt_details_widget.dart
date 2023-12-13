import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/global/styles/text_styles.dart';

import 'package:wehealth/models/data_model/user_appt_list_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';

class ApptDetailTile extends StatelessWidget {
  const ApptDetailTile({
    Key? key,
    required this.data,
    this.isTele = false,
    this.teleFunc,
  })  : assert(!(isTele == true && teleFunc == null),
            "This function can't be empty!"),
        super(key: key);
  final UserApptModel data;
  final bool isTele;
  final VoidCallback? teleFunc;

  @override
  Widget build(BuildContext context) {
    final finalDateString = DateFormat("d MMM, y").format(DateFormat("yyyy-MM-dd").parse(data.appointmentDate!));
    //  ApptSlotData aptSlot = ApptSlotData();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        // height: isTele ? 250 : 200,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundImage:
                      AssetImage("assets/icons/main_icon.png"),
                ),
                const SizedBox(width: 8),
                Text(
                  apptStatusToString(data.status),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
                // const Spacer(),

                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time, size: 14.sp),
                          const SizedBox(width: 8),
                          Text(
                            data.appointmentTime!,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              data.deptName ?? data.doctorfirstName ?? "No Header!",
              style: TextStyles.extraSmallText14BStyle().copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const Expanded(
                    flex: 2,
                    child: Text(
                      "Appt Type",
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    )),
                const Text(
                  ":",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 14),
                Expanded(
                    flex: 3,
                    child: Text(
                      apptTypeToString(data.appointmentType ?? -1),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    )),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Expanded(
                    flex: 2,
                    child: Text(
                      "Appt Date",
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    )),
                const Text(
                  ":",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 14),
                Expanded(
                    flex: 3,
                    child: Text(
                      finalDateString,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    )),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Expanded(
                    flex: 2,
                    child: Text(
                      "Appt Time",
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    )),
                const Text(
                  ":",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 14),
                Expanded(
                    flex: 3,
                    child: Text( //"${aptSlot.fromTime}-${aptSlot.toTime}",
                      data.appointmentTime ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    )),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Expanded(
                    flex: 2,
                    child: Text(
                      "Notes",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    )),
                Text(
                  ":",
                  style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey.shade400),
                ),
                const SizedBox(width: 14),
                Expanded(
                  flex: 3,
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.loose(const Size.fromHeight(50)),
                    child: SingleChildScrollView(
                      child: Text(
                        (data.note != null && data.note!.isNotEmpty)
                            ? data.note!
                            : "No Notes",
                        softWrap: true,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (isTele) const SizedBox(height: 8),
            if (isTele)
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                      ),
                      onPressed: teleFunc,
                      child: const Text("ENTER ROOM"),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
