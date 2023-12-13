import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/appt_controller/appt_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/appt_clinic_day_slot_model.dart';
import 'package:wehealth/models/data_model/user_appt_doctor_list.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_text_field.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';

import '../../../notifications/notification_screen.dart';
import '../../drawer_items.dart';

class AddDoctorAppointment extends StatefulWidget {
  const AddDoctorAppointment({Key? key}) : super(key: key);

  @override
  State<AddDoctorAppointment> createState() => _AddDoctorAppointmentState();
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

class _AddDoctorAppointmentState extends State<AddDoctorAppointment> {
  final _dateController = TextEditingController();
  final _apptTypeController = TextEditingController();
  final _timeController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.find<ApptController>().fetchDoctorApptDoctorList();
  }

  ApptSlotData _selectedSlot = ApptSlotData();
  DoctorApptDoctor _doctor = DoctorApptDoctor();
  String _selectedDoctor = "";
  String _selectedDay = "";
  int apptApproval = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: Text("Doctor Appointment", style: TextStyle(fontSize: 16.sp, overflow: TextOverflow.fade),),
           automaticallyImplyLeading: !Platform.isIOS,
        leading: Platform.isIOS  
        ?  IconButton(onPressed: (){
          Get.back();
          }, icon: const Icon(Icons.close),) 
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
                          titleColor: Colors.orange.shade700,
                          options: (controller.apptDoctorList == null)
                              ? []
                              : controller.apptDoctorList!
                                  .map((e) => "${e.firstName} ${e.lastName}")
                                  .toList(),
                          selectedItem: _selectedDoctor,
                          onChange: (value) {
                            setState(() {
                              _selectedDoctor = value!;
                            });
                            if (controller.apptDoctorList != null &&
                                _selectedDoctor != "") {
                              final doctor = controller.apptDoctorList!
                                  .where((e) =>
                                      "${e.firstName} ${e.lastName}" == value)
                                  .first;
                              _doctor = doctor;
                            } else {
                              _doctor = DoctorApptDoctor();
                            }
                          },
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
                                          .add(const Duration(days: 730)));
                                  if (date != null) {
                                    setState(() {
                                      _dateController.text =
                                          DateFormat("yyyy-MM-dd").format(date);
                                      _selectedDay = dayMap[date.weekday] ?? "";
                                    });
                                    Get.showOverlay(
                                        loadingWidget:
                                            const OverlayLoadingIndicator(),
                                        asyncFunction: () async {
                                          await controller.fetchDoctorApptSlots(
                                              _doctor.professionalID ?? 0);
                                          await controller
                                              .fetchDoctorApptBookedSlots(
                                                  _doctor.professionalID ?? 0,
                                                  _dateController.text);
                                        });
                                  }
                                },
                          child: AbsorbPointer(
                            absorbing: true,
                            child: HorizontalTextFormField(
                              controller: _dateController,
                              title: "Date:",
                              titleColor: Colors.orange.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        AbsorbPointer(
                          absorbing: true,
                          child: HorizontalTextFormField(
                            controller: _apptTypeController,
                            title: "Appointment Type:",
                            titleColor: Colors.orange.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AbsorbPointer(
                          absorbing: true,
                          child: HorizontalTextFormField(
                            controller: _timeController,
                            title: "Appointment Time:",
                            titleColor: Colors.orange.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (controller.doctorApptSlots != null &&
                            _doctor.professionalID != null &&
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
                            titleColor: Colors.orange.shade700,
                            maxLines: 3),
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
                  backgroundColor: Colors.orange.shade700,
                ),
                onPressed: () async {
                  if (_selectedSlot.id != null &&
                      _doctor.professionalID != null) {
                    final success = await controller.postDoctorApptRequest(
                        _selectedSlot,
                        _doctor,
                        _dateController.text,
                        _notesController.text
                        
                        );
                    if (success != null && success == true) {
                      showToast("Appointment added successfully!", context);
                      Get.back();
                    }
                  }
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

class SlotWidget extends StatelessWidget {
  const SlotWidget({
    Key? key,
    required this.isSelected,
    required this.type,
    required this.time,
    required this.isBlocked,
    required this.onSelect,
  }) : super(key: key);
  final int type;
  final String time;
  final bool isBlocked;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isBlocked ? null : onSelect,
      child: Container(
        decoration: BoxDecoration(
          color: isBlocked
              ? Colors.red
              : isSelected
                  ? Colors.blue
                  : getColorBasedOfAppt(type),
        ),
        padding: const EdgeInsets.all(6),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            time,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class HorizontalTitledDropdown<T> extends StatelessWidget {
  HorizontalTitledDropdown({
    Key? key,
    required this.title,
    this.titleColor,
    required List<T> options,
    required T selectedItem,
    this.onChange,
    this.titleStyle,
  })  : _items = (options is List<String> && !options.contains(selectedItem))
            ? [("Select an item" as T), ...options]
            : options,
        _selected = ((selectedItem is String && selectedItem == "")
            ? "Select an item"
            : selectedItem) as T,
        super(key: key);

  final String title;
  final Color? titleColor;
  final List<T> _items;
  final T _selected;
  final ValueChanged<T?>? onChange;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: titleStyle ?? TextStyles.extraSmallText14BStyle().copyWith(color: titleColor ?? Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 6,
          child: SizedBox(
            height: 60.h,
            child: DropdownButtonFormField<T>(
              isExpanded: true,
              decoration: decoration,
              value: _selected,
              alignment: Alignment.center,
              items: _items
                  .map(
                    (value) => DropdownMenuItem<T>(
                      value: value,
                      child: Text(
                        value.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChange,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
