import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/appt_clinic_day_slot_model.dart';

import '../drawer/home/appointment/appt_constants.dart';

class SlotPickerWidget extends StatefulWidget {
  const SlotPickerWidget({
    Key? key,
    this.userHasSlot = false,
    required this.allSlots,
    required this.bookedSlots,
    required this.selectedDate,
  }) : super(key: key);
  final bool userHasSlot;
  final List<ApptSlotData> allSlots;
  final List<DayBookedSlotsData> bookedSlots;
  final DateTime selectedDate;

  @override
  State<SlotPickerWidget> createState() => _SlotPickerWidgetState();
}

class _SlotPickerWidgetState extends State<SlotPickerWidget> {
  ApptSlotData _daySlotData = ApptSlotData();
  @override
  Widget build(BuildContext context) {
    log(widget.userHasSlot.toString());
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100.h,
                color: getColorBasedOfAppt(
                    widget.allSlots.firstOrNull?.appointmentType ?? 0),
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat("EEE, d MMM")
                                .format(widget.selectedDate),
                            style: TextStyles.normalTextBoldStyle()
                                .copyWith(color: Colors.white, fontSize: 15.sp),
                          ),
                          Text(
                            (_daySlotData.appointmentType != null)
                                ? apptTypeToString(
                                    _daySlotData.appointmentType!)
                                : "",
                            style: TextStyles.normalTextBoldStyle()
                                .copyWith(color: Colors.white, fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 6,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          _daySlotData.fromTime ?? "00:00",
                          style: TextStyles.extraLargeTextBoldStyle()
                              .copyWith(color: Colors.white, fontSize: 22.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
                child: widget.allSlots.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                           widget.userHasSlot? "You have booked appointment on this day." : "No slot available for this date!",
                          textAlign: TextAlign.center,
                          style: TextStyles.smallTextBoldStyle()
                              .copyWith(color: Colors.black),
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Time Slot",
                            style: TextStyles.normalTextBoldStyle(),
                          ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              // crossAxisAlignment: ,
                              spacing: 10,
                              children: widget.allSlots
                                  .map(
                                    (timeSlot) => (widget.bookedSlots.any(
                                            (element) =>
                                                element
                                                    .professionalScheduleID ==
                                                timeSlot.id))
                                        ? GestureDetector(
                                            onTap: () {
                                              Get.rawSnackbar(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 5),
                                                backgroundColor: Colors.red,
                                                borderRadius: 6,
                                                title: "Can't select!",
                                                message:
                                                    "This slot is fully booked!",
                                              );
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFF4444),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              padding: const EdgeInsets.all(12),
                                              child: Text(
                                                timeSlot.fromTime!,
                                                style: TextStyles
                                                        .extraSmallBoldTextStyle()
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () => setState(() {
                                              _daySlotData = timeSlot;
                                            }),
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 4.h),
                                              decoration: BoxDecoration(
                                                color: getColorBasedOfAppt(
                                                    timeSlot.appointmentType),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              padding: EdgeInsets.all(8.sp),
                                              child: Text(
                                                timeSlot.fromTime!,
                                                style: TextStyles
                                                        .extraSmallBoldTextStyle()
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back(result: null);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyles.extraSmallTextStyle().copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () {
                        Get.back(
                            result: (_daySlotData.id == null)
                                ? null
                                : _daySlotData);
                      },
                      child: Text(
                        widget.userHasSlot? "" : "Confirm",
                        style: TextStyles.extraSmallTextStyle().copyWith(
                          color: Colors.green,
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
    );
  }
}
