import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/appt_controller/appt_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/appt_clinic_day_slot_model.dart';
import 'package:wehealth/models/data_model/appt_hopital_dep_list_model.dart';
import 'package:wehealth/screens/dashboard/notifications/notification_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/appt_slot_pick_widget.dart';
import 'package:wehealth/screens/dashboard/widgets/custom_check_list_tile.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/vertical_text_form_field.dart';
import 'package:wehealth/screens/dashboard/widgets/vertical_titled_dropdown.dart';

import '../../drawer_items.dart';
import 'appt_constants.dart';

class AddClinicAppointment extends StatefulWidget {
  const AddClinicAppointment({Key? key}) : super(key: key);

  @override
  State<AddClinicAppointment> createState() => _AddClinicAppointmentState();
}

class _AddClinicAppointmentState extends State<AddClinicAppointment> {
  final _apptTypeCon = TextEditingController();
  final _apptTimeCon = TextEditingController();
  final _apptDateCon = TextEditingController();
  List<String> hospitals = [];
  String _selectedHospital = "";
  String _selectedDepString = "";
  DateTime? _selectedDate;
  bool _agreed = false;
  HospitalDepData? _selectedDep;
  ApptSlotData? _selectedSlot;
  late DateTime now;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    Get.find<ApptController>().fetchApptHospitalList();
  }

  DateTime get initialDate => now.weekday == DateTime.saturday
      ? now.add(const Duration(days: 2))
      : now.weekday == DateTime.sunday
          ? now.add(const Duration(days: 1))
          : now;

  DateTime lastDate(int addedDays) => ((initialDate.weekday + addedDays) > 5)
      ? initialDate.add(Duration(
          days: (2 *
                  (math.max<int>(
                      ((initialDate.weekday + addedDays) ~/ 7), 1))) +
              addedDays))
      : initialDate.add(Duration(days: addedDays));

  apptSelectionFlow(ApptController controller) async {
    log("${((initialDate.weekday + _selectedDep!.dayBefore!) ~/ 7)}");
    if (_selectedDep != null) {
      DateTime? selectedDate;

      if (_selectedDep?.id != 7) {
        selectedDate = await showDatePicker(
          context: context,
          helpText: "Select Appointment Date",
          selectableDayPredicate: (day) {
            return day.weekday != DateTime.saturday &&
                day.weekday != DateTime.sunday;
          },
          initialDate: initialDate,
          firstDate: now,
          lastDate: lastDate(_selectedDep!.dayBefore ?? 0),
        );
      } else {
        selectedDate = await showDatePicker(
          context: context,
          helpText: "Select Appointment Date",
          /* selectableDayPredicate: (day) {
          return day.weekday != DateTime.saturday &&
              day.weekday != DateTime.sunday;
        }, */
          initialDate: DateTime.now(),
          firstDate: now,
          lastDate: DateTime.now().add(
            Duration(
              days: (_selectedDep!.dayBefore ?? 0),
            ),
          ),
        );
      }

      if (selectedDate != null) {
        setState(() {
          _selectedDate = selectedDate;
        });
        await daySlotSelector(controller);
      }
    }
  }

  daySlotSelector(ApptController controller) async {
    if (_selectedDep != null && _selectedDate != null) {
      final dayData = await Get.showOverlay(
        loadingWidget: const OverlayLoadingIndicator(),
        asyncFunction: () => controller.repository
            .getClinicApptDaySlots(_selectedDep!.id!, _selectedDate!),
      );

      if (dayData?.slots?.isNotEmpty ?? false) {
        final dayDataStatus = await Get.showOverlay(
          loadingWidget: const OverlayLoadingIndicator(),
          asyncFunction: () => controller.repository
              .getClinicApptDaySlotsStatus(
                  dayData?.slots?.first.professionalId ?? 0, _selectedDate!),
        );

        ApptSlotData? data = await Get.dialog(
          SlotPickerWidget(
            allSlots: dayData?.slots ?? [],
            bookedSlots: dayDataStatus?.bookedSlotsList ?? [],
            selectedDate: _selectedDate!,
          ),
          name: "Select Time Slot",
        );
        if (data != null) {
          setState(() {
            _selectedSlot = data;
          });
        }
      } else {
        await Get.dialog(
          SlotPickerWidget(
            userHasSlot: controller.userApptActiveList?.any((element) =>
                    DateFormat("yyyy-MM-dd").parse(element.appointmentDate!) ==
                    DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day)) ??
                false,
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
    if (_selectedDate != null) {
      _apptDateCon.text = DateFormat("dd/MM/yyyy").format(_selectedDate!);
    }
    if (_selectedSlot != null) {
      _apptTypeCon.text = apptTypeToString(_selectedSlot!.appointmentType!);
    }
    if (_selectedSlot != null) _apptTimeCon.text = _selectedSlot!.fromTime!;
    return Scaffold(
      drawer: Platform.isAndroid ? const DrawerSide() : null,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: Text("Clinic Appointment", style: TextStyle(fontSize: 16.sp, overflow: TextOverflow.fade),),
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
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.amberAccent,
            onPrimary: Color(0xffF02E65),
            onSurface: Color.fromARGB(255, 66, 125, 145),
          ),
        ),
        child: GetBuilder<ApptController>(builder: (controller) {
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
                          options: controller.apptHospitals
                                  ?.map((hospitalData) => hospitalData.name!)
                                  .toList() ??
                              [],
                          selectedItem: _selectedHospital,
                          title: "Hospital:",
                          titleColor: Colors.orange.shade600,
                          onChange: (value) {
                            log("Called!");
                            setState(() {
                              _selectedHospital = value!;
                            });
                            Get.showOverlay(
                              loadingWidget: const OverlayLoadingIndicator(),
                              asyncFunction: () => controller
                                  .fetchHospitalDepList(_selectedHospital),
                            );
                          },
                        ),
                        VerticalTitledDropdown<String>(
                          options: controller.hospitalDeps
                                  ?.map((depData) => depData.deptName!)
                                  .toList() ??
                              [],
                          selectedItem: _selectedDepString,
                          title: "Department:",
                          titleColor: Colors.orange.shade600,
                          onChange: (value) {
                            if (value != null) {
                              _selectedDepString = value;
                              if (controller.hospitalDeps!.any(
                                  (element) => element.deptName == value)) {
                                _selectedDep = controller.hospitalDeps
                                    ?.where((item) =>
                                        item.deptName == _selectedDepString)
                                    .first;
                              }
                              log(_selectedDep!.toJson().toString());
                              setState(() {});
                            } else {
                              _selectedDep = null;
                            }
                          },
                        ),
                        GestureDetector(
                          onTap: () async =>
                              await apptSelectionFlow(controller),
                          child: AbsorbPointer(
                            absorbing: true,
                            child: VerticalFormField(
                              controller: _apptDateCon,
                              title: "Date:",
                              titleColor: Colors.orange.shade600,
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
                              titleColor: Colors.orange.shade600,
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
                              titleColor: Colors.orange.shade600,
                            ),
                          ),
                        ),
                        if (_selectedDate != null)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.info,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text:
                                              "Patient is required to be at the clinic ",
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey,
                                            fontSize: 15.sp,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: "30 minutes before",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  " the appointment time. Patients who arrive",
                                            ),
                                            TextSpan(
                                              text:
                                                  ", his/her appointment slot will be deemed",
                                            ),
                                            TextSpan(
                                              text: " cancelled",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  " and the patient have to make a ",
                                            ),
                                            TextSpan(
                                              text: "new appointment. \n\n",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "Pesakit perlu berada di klinik ",
                                            ),
                                            TextSpan(
                                              text: "30 minit sebelum",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  " waktu temujanji. Pesakit yang hadir",
                                            ),
                                            TextSpan(
                                              text: " lewat",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ", akan dikira ",
                                            ),
                                            TextSpan(
                                              text: "terbatal",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  " temujanjinya, dan pesakit perlu membuat ",
                                            ),
                                            TextSpan(
                                              text: "temujanji baru.",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                checkColor: Colors.white,
                activeColor: Colors.purple.shade700,
                

                title: RichText(
                 
                  text: TextSpan(
                    text: "Saya faham dan setuju dengan ",
                    style: TextStyles.extraSmallBoldTextStyle()
                        .copyWith(color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => showAgreementDialogue(),
                        text: "Penyataan PPUM\n",
                        style: TextStyles.extraSmallBoldTextStyle()
                            .copyWith(color: Colors.purple, 
                            fontSize: 14.sp,
                        fontWeight: FontWeight.bold,),
                      ),
                      TextSpan(
                        text: "I understand and agree wtih the ",
                        style: TextStyles.extraSmallBoldTextStyle().copyWith(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => showAgreementDialogue(),
                        text: "PPUM Statement",
                        style: TextStyles.extraSmallBoldTextStyle().copyWith(
                          color: Colors.purple,
                          fontStyle: FontStyle.italic,
                          fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
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
                height: 50,
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.orange.shade600,
                    side: BorderSide(
                      color: Colors.amber.shade600,
                    ),
                    // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (_selectedDep != null && _selectedSlot != null) {
                      if (_agreed) {
                        try {
                          await Get.showOverlay(
                            loadingWidget: const OverlayLoadingIndicator(),
                            asyncFunction: () async {
                            Get.find<ApptController>().postHospitalApptRequest(
                            _selectedSlot!, _selectedDep!, _selectedDate!);
                            Get.back();
                              
                            },
                          );                      
                        } catch (err) {
                          log(err.toString());
                        }
                      } else {
                        showToast(
                            "You have to agree with PPUM terms and conditions in orders to proceed.",
                            context);
                      }
                    } else {
                      showToast("Please Select Timeslot", context);
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
      ),
    );
  }
}

class ApptAgreementWidget extends StatelessWidget {
  const ApptAgreementWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox.shrink(),
                      Text(
                        "Disclaimer",
                        style: TextStyles.smallTextBoldStyle(),
                      ),
                      const CloseButton(),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                    child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                              style: TextStyles.normalTextStyle()
                                  .copyWith(color: Colors.deepPurple),
                              text:
                                  "Selamat Datang ke Sistem Appointment Based Clinic Klinik Rawatan Utama UMMC\n",
                              children: [
                                TextSpan(
                                  text:
                                      "Welcome to UMMC Primary Care Clinic Appointment Based Clinic System\n\n",
                                  style: TextStyles.normalTextStyle().copyWith(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),
                                ),
                                const TextSpan(
                                  text:
                                      "(NOTIS: Sistem janji temu ini hanya untuk pesakit yang STABIL sahaja)\n",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      "(NOTICE: This appointment system is only for the STABLE patients)\n\n",
                                  style: TextStyles.normalTextStyle()
                                      .copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text:
                                      "Jika anda mempunyai gejala dan risiko seperti dibawah, sila pergi ke fasiliti atau klinik kesihatan yang berdekatan. Sebaik sahaja anda sampai, sila beritahu staf gejala dan risiko anda:\n",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      "If you have any symptoms and risk factors as below, please walk in or go to the nearest health facility. Upon your arrival at the clinic, please inform the staff when you arrive.\n\n",
                                  style: TextStyles.normalTextStyle()
                                      .copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text: "Gejala dan risiko termasuk:\n",
                                ),
                                const TextSpan(
                                  text:
                                      "Symptoms and risk factors include:\n\n",
                                ),
                                const TextSpan(
                                  text: "\u2610 Demam/",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "Fever\n",
                                  style: TextStyles.normalTextStyle()
                                      .copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text: "\u2610 Sakit tekak/",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "Sore throat\n",
                                  style: TextStyles.normalTextStyle()
                                      .copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text: "\u2610 Batuk/",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "Cough\n",
                                  style: TextStyles.normalTextStyle()
                                      .copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text: "\u2610 Selsema atau hidung berair/",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "Runny nose\n",
                                  style: TextStyles.normalTextStyle()
                                      .copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text: "\u2610 Kurang atau hilang deria bau/",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "Loss of smell\n",
                                  style: TextStyles.normalTextStyle()
                                      .copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text: "\u2610 Sesak nafas/",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "Shortness of breath\n",
                                  style: TextStyles.normalTextStyle()
                                      .copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text:
                                      "\u2610 Kontak rapat pesakit positif COVID-19/",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      "Close contact to a positive Covid-19 patient\n",
                                  style: TextStyles.normalTextStyle().copyWith(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),
                                ),
                                TextSpan(
                                  text: "Positif ujian saringan COVID-19\n\n",
                                  style: TextStyles.normalTextStyle().copyWith(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),
                                ),
                                const TextSpan(
                                  text:
                                      "Akta 342 Pencegahan dan Pengawalan Penyakit Berjangkit 1988: Anda boleh didakwa jika memberikan maklumat palsu.\n",
                                ),
                                TextSpan(
                                  text:
                                      "Act 342 Prevention and Control of Communicable Diseases 1988: You can be prosecuted if you give false information.\n\n",
                                  style: TextStyles.normalTextStyle().copyWith(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),
                                ),
                                const TextSpan(
                                  text:
                                      "Untuk kes ulangan kronik, sila ikuti temujanji yang telah ditetapkan ataupun jika anda perlu menukar temujanji, sila telefon 03-7949 2171 atau 03-7949 2193\n",
                                ),
                                TextSpan(
                                  text:
                                      "For chronic disease follow up, please follow the appointment that has been set or if you need to change the appointment, please call 03-7949 2171 or 03-7949 2193\n\n",
                                  style: TextStyles.normalTextStyle().copyWith(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),
                                ),
                                const TextSpan(
                                  text:
                                      "Bagi kes-kes KECEMASAN, hendaklah segera mendapatkan rawatan di Jabatan Kecemasan yang berdekatan.\n",
                                ),
                                TextSpan(
                                  text:
                                      "For EMERGENCY cases, should immediately seek treatment at the nearest Emergency Department.\n\n",
                                  style: TextStyles.normalTextStyle().copyWith(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),
                                ),
                                const TextSpan(
                                  text:
                                      "Pelanggan yang telah memperolehi slot temujanji perlu hadir ke klinik 30 MINIT sebelum masa temujanji yang tempah.\n",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      "Customers who have secured an appointment slot must be present at the clinic 30 MINUTES prior to the booked appointment time.\n\n",
                                  style: TextStyles.normalTextStyle()
                                      .copyWith(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const TextSpan(
                                  text:
                                      "Pelanggan yang tidak mengikuti waktu temujanji, temujanji akan dibatalkan secara automatik dan perlu menempah slot pada waktu yang lain yang masih kosong.\n",
                                ),
                                TextSpan(
                                  text:
                                      "For customers who do not follow the appointment time, the appointment will be cancelled automatically and will need to book a slot at another time that is still vacant.\n",
                                  style: TextStyles.normalTextStyle().copyWith(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
