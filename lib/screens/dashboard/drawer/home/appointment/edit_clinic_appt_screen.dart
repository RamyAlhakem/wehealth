import 'dart:developer';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:wehealth/controller/appt_controller/appt_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/models/data_model/appt_clinic_day_slot_model.dart';
import 'package:wehealth/models/data_model/user_appt_list_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';
import 'package:wehealth/screens/dashboard/notifications/notification_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/appt_slot_pick_widget.dart';
import 'package:wehealth/screens/dashboard/widgets/custom_check_list_tile.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/vertical_text_form_field.dart';
import 'package:wehealth/screens/dashboard/widgets/vertical_titled_dropdown.dart';
import '../../drawer_items.dart';
import 'add_clinic_appt.dart';


class EditClinicAppointment extends StatefulWidget {
  const EditClinicAppointment({Key? key, required this.apptModel})
      : super(key: key);
  final UserApptModel apptModel;
  @override
  State<EditClinicAppointment> createState() => _EditClinicAppointmentState();
}

class _EditClinicAppointmentState extends State<EditClinicAppointment> {
  final _apptTypeCon = TextEditingController();
  final _apptTimeCon = TextEditingController();
  final _apptDateCon = TextEditingController();
  DateTime? _selectedDate;
  bool _agreed = true;
  // HospitalDepData? _selectedDep;
  ApptSlotData? _selectedSlot;

  @override
  void initState() {
    super.initState();
    _apptDateCon.text = DateFormat("dd/MM/yyyy")
        .format(stringDateWithTZ.parse(widget.apptModel.appointmentDate ?? ""));
    _apptTypeCon.text = apptTypeToString(widget.apptModel.appointmentType);
    _apptTimeCon.text = widget.apptModel.appointmentTime ?? "";
    _selectedDate =
        stringDateWithTZ.parse(widget.apptModel.appointmentDate ?? "");
  }

  apptSelectionFlow(ApptController controller) async {
    if (widget.apptModel.professionalID != null &&
        widget.apptModel.appointmentDate != null) {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        /*selectableDayPredicate: (day) {
          return !(day.weekday == DateTime.sunday ||
              day.weekday == DateTime.saturday);
        }, */
        helpText: "Select Appointment Date",
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now()
            .add(Duration(days: (widget.apptModel.dayBefore ?? 0))),
      );
      if (selectedDate != null) {
        setState(() {
          _selectedDate = selectedDate;
          _apptDateCon.text = DateFormat("dd/MM/yyyy").format(selectedDate);

          if(_apptDateCon.text == DateFormat("dd/MM/yyyy").format(stringDateWithTZ.parse(widget.apptModel.appointmentDate ?? ""))) {
            Get.rawSnackbar(
              margin: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 5),
              backgroundColor: Colors.green,
              borderRadius: 6,
              animationDuration: const Duration(seconds: 4),
              title: "Message!",
              message: "You have booked appointment on this date ${_apptDateCon.text} with ${widget.apptModel.deptName}!",
            );
            
          }else{
           daySlotSelector(controller);
          }
        });
       
      }
    }
  }

  daySlotSelector(ApptController controller) async {
    if (widget.apptModel.professionalID != null &&
        widget.apptModel.appointmentDate != null) {
      final dayData = await Get.showOverlay(
        loadingWidget: const OverlayLoadingIndicator(),
        asyncFunction: () => controller.repository.getClinicApptDaySlots(
            widget.apptModel.professionalID!, _selectedDate!),
      );

      if (dayData?.slots?.isNotEmpty ?? false) {
        final dayDataStatus = await Get.showOverlay(
          loadingWidget: const OverlayLoadingIndicator(),
          asyncFunction: () =>
              controller.repository.getClinicApptDaySlotsStatus(
            dayData?.slots?.first.professionalId ?? 0,
            _selectedDate!,
          ),
        );

        ApptSlotData? data = await Get.dialog(
          SlotPickerWidget(
            allSlots: dayData?.slots ?? [],
            bookedSlots: dayDataStatus?.bookedSlotsList ?? [],
            selectedDate: _selectedDate!,
          ),
          name: "Select Time Slot",
        );
        log('Selected slot => ${data?.toJson().toString()}');
        if (data != null) {
          setState(() {
            _apptTypeCon.text = apptTypeToString(data.appointmentType);
            _apptTimeCon.text = data.fromTime ?? '';
            _selectedSlot = data;
          });
        }
      } else {
        await Get.dialog(
          SlotPickerWidget(
            allSlots: const [],
            bookedSlots: const [],
            selectedDate: _selectedDate!,
          ),
        );
      }
    }
  }

  showAgreementDialogue() async {
    log("agreement dialogue");
    Get.bottomSheet(
      const ApptAgreementWidget(),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      ignoreSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    log(widget.apptModel.toJson().toString());
    return IosScaffoldWrapper(
    title: "Clinic Appointment",
    appBarColor: Colors.orange.shade700,
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.amberAccent,
            onPrimary: Color(0xffF02E65),
            onSurface: Color.fromARGB(255, 66, 125, 145),
          ),
        ),
        child: GetBuilder<ApptController>(builder: (controller) {
          final hopitalData = controller.apptHospitals
              ?.where(
                (element) =>
                    element.id == int.parse(widget.apptModel.hosApptID ?? ''),
              )
              .firstOrNull;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12),
                    child: Column(
                      children: [
                        VerticalTitledDropdown<String>(
                          options: [hopitalData?.name ?? ""],
                          selectedItem: hopitalData?.name ?? "",
                          title: "Hospital:",
                          titleColor: Colors.orange.shade700,
                        ),
                        VerticalTitledDropdown<String>(
                          options: [widget.apptModel.deptName ?? ""],
                          selectedItem: widget.apptModel.deptName ?? "",
                          title: "Department:",
                          titleColor: Colors.orange.shade700,
                        ),
                        GestureDetector(
                          onTap: () async =>
                              await apptSelectionFlow(controller),
                          child: AbsorbPointer(
                            absorbing: true,
                            child: VerticalFormField(
                              controller: _apptDateCon,
                              title: "Date:",
                              titleColor: Colors.orange.shade700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async => daySlotSelector(controller),
                          child: AbsorbPointer(
                            absorbing: true,
                            child: VerticalFormField(
                              controller: _apptTypeCon,
                              title: "Appointment Type:",
                               titleColor: Colors.orange.shade700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async => daySlotSelector(controller),
                          child: AbsorbPointer(
                            absorbing: true,
                            child: VerticalFormField(
                              controller: _apptTimeCon,
                              title: "Appointment Time:",
                               titleColor: Colors.orange.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomCheckboxListTile(
                horizontalTitleGap: 4,
                value: _agreed,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.purple.shade700,

                title: RichText(
                  text: TextSpan(
                    text: "Saya faham dan setuju dengan ",
                    style: TextStyles.extraSmallBoldTextStyle()
                        .copyWith(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => showAgreementDialogue(),
                        text: "Penyataan PPUM\n",
                        style: TextStyles.extraSmallBoldTextStyle()
                            .copyWith(color: Colors.purple, fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "I understand and agree wtih the ",
                        style: TextStyles.extraSmallBoldTextStyle().copyWith(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 14.sp, fontWeight: FontWeight.bold
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => showAgreementDialogue(),
                        text: "PPUM Statement",
                        style: TextStyles.extraSmallBoldTextStyle().copyWith(
                          color: Colors.purple,
                          fontStyle: FontStyle.italic,
                          fontSize: 14.sp, fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _agreed = value!;
                  });
                },
              ),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.orange.shade700,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange.shade700
                        ),
                        onPressed: () async {
                          Get.showOverlay(
                            loadingWidget: const OverlayLoadingIndicator(),
                            asyncFunction: () async {
                              if (_agreed && _selectedSlot != null) {
                                bool? check =
                                    await controller.reqApptReschedule(
                                  widget.apptModel,
                                  _selectedSlot!,
                                  _selectedDate!,
                                );

                                /* switch (check) {
                                  case true:
                                    
                                    break;
                                  case false:
                                    Get.rawSnackbar(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      backgroundColor: Colors.black,
                                      borderRadius: 6,
                                      title: "Sorry!",
                                      message:
                                          "Couldn't reschedule the appointment!",
                                    );
                                    break;
                                  default:
                                    Get.rawSnackbar(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 5,
                                      ),
                                      backgroundColor: Colors.red,
                                      borderRadius: 6,
                                      title: "OH NO!",
                                      message:
                                          "An error occured on the process!",
                                    );
                                } */
                              }
                            },
                          );
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
                          backgroundColor: Colors.orange.shade700
                        ),
                        onPressed: () async {
                          if (_agreed) {
                           /*  HospitalApptRequestModel model =
                                HospitalApptRequestModel.fromJson(
                                    widget.apptModel.toJson());
                            log(model.toJson().toString()); */
                            bool? check = await Get.showOverlay<bool?>(
                              loadingWidget: const OverlayLoadingIndicator(),
                              asyncFunction: () async =>
                                  await controller.reqApptCancel(widget.apptModel.id!),
                            );

                            if (check == true) {
                              log('$check');
                              Get.back();
                              Get.rawSnackbar(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                backgroundColor: Colors.green,
                                borderRadius: 6,
                                title: "Congratulations!",
                                message: "Appointment cancelled!",
                              );
                            }
                            if (check == false) {
                              Get.rawSnackbar(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                backgroundColor: Colors.black,
                                borderRadius: 6,
                                title: "Sorry!",
                                message: "Couldn't cancel the appointment!",
                              );
                            }
                            if (check == null) {
                              Get.rawSnackbar(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                backgroundColor: Colors.red,
                                borderRadius: 6,
                                title: "OH NO!",
                                message: "An error occured on the process!",
                              );
                            }
                          }
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
          );
        }),
      ),
    );
  }
}