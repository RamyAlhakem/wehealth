import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/appt_controller/appt_controller.dart';
import 'package:wehealth/models/data_model/appt_clinic_day_slot_model.dart';
import 'package:wehealth/models/data_model/user_appt_list_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_titled_dropdown.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/single_slot_widget.dart';

import '../../../notifications/notification_screen.dart';
import '../../drawer_items.dart';

class EditDoctorAppointment extends StatefulWidget {
  const EditDoctorAppointment({
    Key? key,
    required this.doctorAppt,
  }) : super(key: key);
  final UserApptModel doctorAppt;

  @override
  State<EditDoctorAppointment> createState() => _EditDoctorAppointmentState();
}

const dayMap = {
  1: "monday",
  2: "tuesday",
  3: "wednesday",
  4: "thursday",
  5: "friday",
  6: "saturday",
  7: "sunday",
};

class _EditDoctorAppointmentState extends State<EditDoctorAppointment> {
  final _dateController = TextEditingController();
  final _apptTypeController = TextEditingController();
  final _timeController = TextEditingController();
  final _notesController = TextEditingController();
  late final String _selectedDoctor;

  @override
  void initState() {
    super.initState();
    _selectedDoctor =
        "${widget.doctorAppt.doctorfirstName} ${widget.doctorAppt.doctorlastName}";
  }

  ApptSlotData _selectedSlot = ApptSlotData();
  // final DoctorApptDoctor _doctor = DoctorApptDoctor();
  String _selectedDay = "";
  DateTime? _selectedDate;
  int apptApproval = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Platform.isAndroid ? const DrawerSide() : null,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: Text(
          "Doctor Appointment",
          style: TextStyle(fontSize: 16.sp, overflow: TextOverflow.fade),
        ),
        automaticallyImplyLeading: !Platform.isIOS,
        leading: Platform.isIOS
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close),
              )
            : null,
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
      body: GetBuilder<ApptController>(builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.fetchDoctorApptDoctorList();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12),
                    child: Column(
                      children: [
                        HorizontalTitledDropdown<String>(
                          title: "Doctor:",
                          options: [_selectedDoctor],
                          selectedItem: _selectedDoctor,
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: (_selectedDoctor == "")
                              ? null
                              : () async {
                                  DateTime? date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 730)),
                                  );
                                  if (date != null) {
                                    setState(() {
                                      _dateController.text =
                                          DateFormat("yyyy-MM-dd").format(date);
                                      _selectedDate = date;
                                      _selectedDay = dayMap[date.weekday] ?? "";
                                    });
                                    Get.showOverlay(
                                        loadingWidget:
                                            const OverlayLoadingIndicator(),
                                        asyncFunction: () async {
                                          await controller.fetchDoctorApptSlots(
                                              widget.doctorAppt
                                                      .professionalID ??
                                                  0);
                                          await controller
                                              .fetchDoctorApptBookedSlots(
                                            widget.doctorAppt.professionalID ??
                                                0,
                                            _dateController.text,
                                          );
                                        });
                                  }
                                },
                          child: AbsorbPointer(
                            absorbing: true,
                            child: HorizontalTextFormField(
                              controller: _dateController,
                              title: "Date:",
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        AbsorbPointer(
                          absorbing: true,
                          child: HorizontalTextFormField(
                            controller: _apptTypeController,
                            title: "Appointment Type:",
                          ),
                        ),
                        const SizedBox(height: 8),
                        AbsorbPointer(
                          absorbing: true,
                          child: HorizontalTextFormField(
                            controller: _timeController,
                            title: "Appointment Time:",
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (controller.doctorApptSlots != null &&
                            widget.doctorAppt.professionalID != null &&
                            _dateController.text != "")
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GridView(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 4,
                                      childAspectRatio: 16 / 8),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: controller
                                  .slotsForDay(_selectedDay)
                                  .map(
                                    (timeSlot) => SlotWidget(
                                      isSelected:
                                          timeSlot.id == _selectedSlot.id,
                                      type: timeSlot.appointmentType ?? 0,
                                      time: timeSlot.fromTime ?? "",
                                      isBlocked: controller
                                              .doctorApptBookedSlots
                                              ?.any((element) =>
                                                  element
                                                      .professionalScheduleID ==
                                                  timeSlot.id) ??
                                          true,
                                      onSelect: () {
                                        _apptTypeController.text =
                                            apptTypeToString(
                                                timeSlot.appointmentType);
                                        _timeController.text =
                                            "${timeSlot.fromTime}-${timeSlot.toTime}";
                                        setState(() {
                                          _selectedSlot = timeSlot;
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        const SizedBox(height: 8),
                        HorizontalTextFormField(
                          controller: _notesController,
                          title: "Notes:",
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
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
                  backgroundColor: Colors.orange.shade600,
                ),
                onPressed: () async {
                  if (_selectedSlot.id != null && _selectedDate != null) {
                    await Get.showOverlay(
                      loadingWidget: const OverlayLoadingIndicator(),
                      asyncFunction: () async =>
                          await Get.find<ApptController>().reqApptReschedule(
                        widget.doctorAppt,
                        _selectedSlot,
                        _selectedDate!,
                        _notesController.text,
                      ),
                    );
                  }
                  /* if (_selectedSlot.id != null &&
                      _doctor.professionalID != null) {
                    final success = await controller.postDoctorApptRequest(
                        _selectedSlot,
                        _doctor,
                        _dateController.text,
                        _notesController.text);
                    if (success != null && success == true) {
                      showToast("Appointment added successfully!", context);
                      Get.back();
                    }
                  } */
                },
                child: const Text(
                  "REQUEST",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
