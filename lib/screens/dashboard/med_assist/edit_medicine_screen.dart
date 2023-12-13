import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import 'package:wehealth/models/data_model/user_medicine_data_wrapper.dart';
import 'package:wehealth/screens/dashboard/med_assist/med_assist_constants.dart';
import 'package:wehealth/screens/dashboard/widgets/drawer_notification_scaffold.dart';
import '../../../models/data_model/medicine_data_posting_model.dart';
import '../widgets/scrolling_date_picker.dart';

class EditMedicineDetailsScreen extends StatefulWidget {
  const EditMedicineDetailsScreen({Key? key, required this.data})
      : super(key: key);

  final UserMedicineData data;

  @override
  State<EditMedicineDetailsScreen> createState() =>
      _EditMedicineDetailsScreenState();
}

class _EditMedicineDetailsScreenState extends State<EditMedicineDetailsScreen> {
  final dayFormat = DateFormat("dd-MM-yyyy");
  String? selectedInstruction;

  final instructions = [
    "Before Food",
    "After Food",
    "With Food",
    "No Food Instruction",
    "Empty Stomach",
  ];

  final startDateCon = TextEditingController();
  final endDateCon = TextEditingController();
  final quantityCon = TextEditingController();
  final medicationReminderCon = TextEditingController();
  final pharmacyRefilCon = TextEditingController();
  final daysCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    insertValues();
  }

  insertValues() async {
    startDateCon.text = widget.data.startDate ?? "";
    endDateCon.text = widget.data.endDate ?? "";
    quantityCon.text = widget.data.quantitySupplied ?? "";
    medicationReminderCon.text = widget.data.reminderType ?? "";
    pharmacyRefilCon.text = widget.data.refilReminder ?? "";
    daysCon.text = widget.data.days ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Med Assist",
      appBarColor: Colors.pink.shade400,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 100.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://images.unsplash.com/photo-1628771065518-0d82f1938462?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fG1lZGljaW5lfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 36.h,
                                width: 36.h,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    iconShapeMap[widget.data.shape
                                            ?.replaceAll(" ", "")] ??
                                        "assets/icons/pills.webp",
                                  ),
                                ),
                              ),
                              Text(
                                widget.data.medicineName ?? "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.data.medicineTakeType ?? "",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const _SectionTitle(
                    title: "Dosage",
                  ),
                  _DataRow(
                    title: "Strength Supplied",
                    data: Text(
                      "${widget.data.strengthSupplied ?? ""} ${widget.data.unit ?? ""}",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  _DataRow(
                    title: "Instruction",
                    data: DropdownButtonFormField(
                      isExpanded: true,
                      decoration: decoration,
                      value: widget.data.instruction,
                      alignment: Alignment.center,
                      items: instructions
                          .map(
                            (value) => DropdownMenuItem(
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
                      onChanged: (value) {
                        setState(() {
                          selectedInstruction = value!;
                          print(selectedInstruction);
                        });
                      },
                    ),
                  ),
                  const Divider(
                    indent: 4,
                    thickness: 1,
                    color: Colors.black87,
                  ),
                  for (String time
                      in (widget.data.timingPerDay?.split(",").toList() ??
                          [])) ...[
                    _DataRow(
                      title: "Strength To Take:",
                      data: RichText(
                        text: TextSpan(
                          text: widget.data.strengthTaken ?? "",
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                          ),
                          children: [
                            TextSpan(
                              text: " ${widget.data.unit ?? ""}",
                              style: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    _DataRow(
                      title: "Take:",
                      data: RichText(
                        text: TextSpan(
                          text: widget.data.variableDose ?? "",
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                          ),
                          children: [
                            TextSpan(
                              text: " ${widget.data.dosageUnit ?? ""}",
                              style: const TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _DataRow(
                      title: "Time:",
                      data: Text(
                        time,
                        style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey.shade800,
                    ),
                  ],
                  const _SectionTitle(title: "Schedule"),
                  _DataRow(
                    title: "Start Date",
                    data: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            controller: startDateCon,
                            validator: (value) {
                              return (value?.isEmpty ?? true)
                                  ? "This field is empty!"
                                  : null;
                            },
                            decoration: decoration,
                            onTap: () async {
                              DateTime? date =
                                  await showBoxyScrollingPicker(context);
                              log(date.toString());
                              if (date != null) {
                                log("Selected Date ${date.toString()}");
                                setState(() {
                                  startDateCon.text = dayFormat.format(date);
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  _DataRow(
                    title: "End Date",
                    data: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLines: 1,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            controller: endDateCon,
                            validator: (value) {
                              return (value?.isEmpty ?? true)
                                  ? "This field is empty!"
                                  : null;
                            },
                            decoration: decoration,
                            onTap: () async {
                              DateTime? date =
                                  await showBoxyScrollingPicker(context);
                              log(date.toString());
                              if (date != null) {
                                log("Selected Date ${date.toString()}");
                                setState(() {
                                  endDateCon.text = dayFormat.format(date);
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  _DataRow(
                    title: "Quantity Supplied",
                    data: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: TextFormField(
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            controller: quantityCon,
                            validator: (value) {
                              return (value?.isEmpty ?? true)
                                  ? "This field is empty!"
                                  : null;
                            },
                            decoration: decoration,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "drop",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _DataRow(
                    title: "Medication Reminder",
                    data: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: TextFormField(
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            controller: medicationReminderCon,
                            validator: (value) {
                              return (value?.isEmpty ?? true)
                                  ? "This field is empty!"
                                  : null;
                            },
                            decoration: decoration,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "minutes before",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _DataRow(
                    title: "Pharmacy Refil Reminder",
                    data: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: TextFormField(
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            controller: pharmacyRefilCon,
                            validator: (value) {
                              return (value?.isEmpty ?? true)
                                  ? "This field is empty!"
                                  : null;
                            },
                            decoration: decoration,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "minutes before",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _DataRow(
                    title: "Days to take",
                    data: TextFormField(
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      controller: daysCon,
                      validator: (value) {
                        return (value?.isEmpty ?? true)
                            ? "This field is empty!"
                            : null;
                      },
                      decoration: decoration,
                    ),
                  ),
                  Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.data.timingPerDay ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.redAccent.withOpacity(0.5),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            //
                          },
                          child: SizedBox(
                            height: 20.h,
                            child: const Center(
                              child: Text(
                                "EDIT",
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue.withOpacity(0.5),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            //
                          },
                          child: SizedBox(
                            height: 20.h,
                            child: const Center(
                              child: Text(
                                "ADD",
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.redAccent.withOpacity(0.5),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            showToast("At least 1 scedule required!", context);
                          },
                          child: SizedBox(
                            height: 20.h,
                            child: const Center(
                              child: Text(
                                "REMOVE",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.cyan,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    final data = MedicineDataPostingModel(
                      medicineID: widget.data.id,
                      colour: widget.data.colour,
                      shape: widget.data.shape,
                      variableDose: int.parse(widget.data.variableDose ?? "0"),
                      strengthSupplied:
                          int.parse(widget.data.strengthSupplied ?? "0"),
                      strengthTaken: widget.data.strengthTaken,
                      timingPerDay: widget.data.timingPerDay,
                      instruction:
                          selectedInstruction ?? widget.data.strengthSupplied,
                      days: widget.data.days,
                      medicineTake: widget.data.medicineTake,
                      medicineTakeType: widget.data.medicineTakeType,
                      startDate: startDateCon.text,
                      endDate: endDateCon.text,
                      quantitySupplied: int.parse(quantityCon.text),
                      ispharmacyrefillreminder: true,
                      dosageUnit: widget.data.dosageUnit,
                      unit: widget.data.unit,
                      units: widget.data.unit,
                      daysBeforeMedicineOut:
                          int.parse(widget.data.daysBeforeMedicineOut ?? "0"),
                      beforeActualTimeRemind:
                          int.parse(widget.data.beforeActualTimeRemind ?? "0"),
                      isreminder: true,
                      refilReminder:
                          int.parse(widget.data.refilReminder ?? "0"),
                    );
                    Get.find<MedAssistController>()
                        .uploadUsersMedicineData(data);
                  },
                  child: SizedBox(
                    height: 32.h,
                    child: const Center(
                      child: Text(
                        "CONFIRM",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  final String title;
  final Widget data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: data,
          )
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 10,
      ),
      child: ColoredBox(
        color: Colors.blue,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
