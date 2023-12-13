// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_controller.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/global/styles/text_field_decoration.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/medicine_data_posting_model.dart';
import 'package:wehealth/models/data_model/medicine_data_wrapper.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';
import 'package:wehealth/screens/dashboard/med_assist/med_assist_dashboard.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import '../notifications/notification_screen.dart';
import 'med_assist_constants.dart';


class MedAssistScreen extends StatefulWidget {
  const MedAssistScreen({Key? key}) : super(key: key);

  @override
  State<MedAssistScreen> createState() => _MedAssistScreenState();
}

class _MedAssistScreenState extends State<MedAssistScreen> {
  List<String> shapes = [
    "Arrow Head",
    "Capsule",
    "Convex Bisect",
    "Diamond",
    "Drops",
    "Flat Quadrisect",
    "Granular",
    "Guard",
    "Half Moon",
  ];

  List<String> timings = [
    "Once a day",
    "Twice a day",
    "Three times a day",
    "Four times a day",
    "Five times a day",
  ];

  List<String> instructions = [
    "Before Food",
    "With Food",
    "After Food",
    "No Food Instructions",
    "Empty Stomach",
  ];

  FocusNode medicineNameNode = FocusNode();
  String shape = "Spoon";
  int _index = 0;
  String timing = "Twice a day";
  String instruction = "Before Food";
  String daySet = "Every Day";
  String unitName = "";
  String takeType = "";
  Color selectedColor = Colors.white;
  List<String> selectedDays = [];
  int selectedTimingindex = 2;
  String get dayData {
    if (daySet == 'Every Day') {
      return daySet;
    } else {
      final dayData = selectedDays.fold<String>(
          '', (previousValue, element) => '$previousValue$element,');
      print(dayData);
      return dayData;
    }
  }

  bool variableDose = false;
  bool pharmacyRefil = false;
  bool medicationReminder = true;

  MedicineData? selectedMedicine;

  final medNameController = TextEditingController();
  final brandNameController = TextEditingController();
  final indicationController = TextEditingController();
  final suppliedStrengthController = TextEditingController();
  final strengthToTakeController = TextEditingController();
  final startDayController = TextEditingController();
  final endDayeController = TextEditingController();
  final quantityController = TextEditingController();
  final medicationReminderController = TextEditingController();
  final pharmacyReminderController = TextEditingController();
  final timingOne = TextEditingController();
  final timingTwo = TextEditingController();
  final timingThree = TextEditingController();
  final timingFour = TextEditingController();
  final timingFive = TextEditingController();

  late GlobalKey _observerWidget;
  late double _axisHeight, _axisWidth;
  late final OverlayEntry overlay;
  final LayerLink layerLink = LayerLink();
  late MedAssistController controller;
  List<MedicineData> match = [];

  String? selectedDate;

  @override
  void initState() {
    super.initState();
    controller = Get.put(MedAssistController());
    controller.fetchMedicineData();
    _observerWidget = LabeledGlobalKey('main_box');
    startDayController.text = DateFormat("dd-MM-yyyy").format(DateTime.now());
    endDayeController.text = DateFormat("dd-MM-yyyy").format(
      DateTime.now().add(Duration(days: 365)),
    );
    timingOne.text = '06:00';
    timingTwo.text = '12:00';
    timingThree.text = '16:00';
    timingFour.text = '20:00';
    timingFive.text = '23:00';
    medicationReminderController.text = '5';
    pharmacyReminderController.text = '5';

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      overlay = _gettingOverlay();
      medNameController.addListener(
        () {
          if (medNameController.text.length > 2) {
            match = Get.find<MedAssistController>()
                .getMatchedMedicinesNameList(medNameController.text);
            log(match.toString());
          } else {
            match.clear();
          }
          final existanceCheck = (controller.listOfAllMedicine?.any(
                  (medicine) =>
                      medicine.medicineName != medNameController.text) ??
              false);
          log(existanceCheck.toString());
          if (medicineNameNode.hasFocus && existanceCheck && !overlay.mounted) {
            Overlay.of(context).insert(overlay);
          }
          if (overlay.mounted &&
              (!existanceCheck || !medicineNameNode.hasFocus)) {
            overlay.remove();
          }
        },
      );
    });
  }

  OverlayEntry _gettingOverlay() {
    _axisHeight = _observerWidget.currentContext!.size!.height;
    _axisWidth = _observerWidget.currentContext!.size!.width;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: _axisWidth,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, _axisHeight + 5),
          child: GetBuilder<MedAssistController>(builder: (controller) {
            return Material(
              elevation: 4,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: match.length,
                    itemBuilder: (context, index) {
                      final medicine = match[index];
                      return ListTile(
                        onTap: () {
                          setState(() {
                            medNameController.text =
                                medicine.medicineName ?? "";
                            brandNameController.text =
                                medicine.brandName ?? "Not available";
                            selectedMedicine = medicine;
                            indicationController.text =
                                medicine.indication ?? "Indication";
                            suppliedStrengthController.text =
                                medicine.strengthsupplied.toString();
                            strengthToTakeController.text = "0";
                            takeType = medicine.take.toString();

                            unitName = medicine.unit ?? "";
                            // quantityController.text =
                            print(medicine.take);
                            print(medicine.unit);
                          });
                          overlay.remove();
                        },
                        title: Text(medicine.medicineName ?? ""),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: const Text("Med Assist"),
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
              onPressed: () {
                Get.to(() => const NotificationScreen());
              },
              icon: const Icon(Icons.message),
            ),
          ],
        ),
        drawer: Platform.isAndroid ? const DrawerSide() : null,
        body: Column(
          children: [
            Expanded(
              child: Stepper(
                currentStep: _index,
                onStepContinue: () {
                  setState(() {
                    _index++;
                  });
                },
                onStepCancel: () {
                  setState(() {
                    _index--;
                  });
                },
                controlsBuilder: (context, details) {
                  if (details.currentStep == 4) {
                    return ElevatedButton(
                      onPressed: () async {
                        String timingText = '';
                        if (selectedTimingindex >= 1) {
                          timingText = timingText + timingOne.text;
                        }
                        if (selectedTimingindex >= 2) {
                          timingText = "$timingText,${timingTwo.text}";
                        }
                        if (selectedTimingindex >= 3) {
                          timingText = "$timingText,${timingThree.text},";
                        }
                        if (selectedTimingindex >= 4) {
                          timingText = "$timingText,${timingFour.text},";
                        }
                        if (selectedTimingindex >= 5) {
                          timingText = "$timingText,${timingFive.text},";
                        }
                        final data = MedicineDataPostingModel(
                          medicineID: selectedMedicine?.id,
                          colour: "#${selectedColor.hexValue}",
                          shape: shape,
                          variableDose: variableDose ? 1 : 0,
                          strengthSupplied:
                              int.tryParse(suppliedStrengthController.text) ??
                                  0,
                          strengthTaken: strengthToTakeController.text,
                          timingPerDay: timingText,
                          instruction: instruction,
                          days: dayData,
                          medicineTake: selectedMedicine?.medicineName,
                          medicineTakeType: selectedMedicine?.indication,
                          startDate: startDayController.text,
                          endDate: endDayeController.text,
                          quantitySupplied:
                              int.tryParse(quantityController.text),
                          ispharmacyrefillreminder: pharmacyRefil,
                          dosageUnit: selectedMedicine?.unit,
                          unit: selectedMedicine?.unit,
                          units: selectedMedicine?.unit,
                          daysBeforeMedicineOut:
                              int.tryParse(pharmacyReminderController.text),
                          beforeActualTimeRemind:
                              int.tryParse(medicationReminderController.text),
                          isreminder: medicationReminder,
                          refilReminder: pharmacyRefil ? 1 : 0,
                        );
                        final res = await Get.showOverlay<bool?>(
                          loadingWidget: const OverlayLoadingIndicator(),
                          asyncFunction: () async =>
                              await controller.uploadUsersMedicineData(data),
                        );
                        if (res ?? false) {
                          Get.off(() => const MedAssistDashboardScreen());
                        }
                      },
                      child: Text(
                        "Confirm & Continue",
                      ),
                    );
                  } else if (details.currentStep == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: (selectedMedicine != null)
                                ? () {
                                    setState(() {
                                      _index++;
                                    });
                                  }
                                : null,
                            child: Text(
                              "Continue",
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _index++;
                              });
                            },
                            child: Text(
                              "Continue",
                            ),
                          ),
                          SizedBox(width: 24),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _index--;
                              });
                            },
                            child: Text(
                              "Back",
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
                steps: [
                  Step(
                    isActive: _index == 0,
                    title: Text(
                      "Medicine Details",
                      style: TextStyles.extraSmallBoldTextStyle(),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //!Forcing method to make a autocomplete system.
                        CompositedTransformTarget(
                          link: layerLink,
                          child: TextFormField(
                            // enabled: false,
                            focusNode: medicineNameNode,
                            controller: medNameController,
                            onTap: () {
                              // selectedMedicine = null;
                              // medNameController.text = "";
                            },
                            validator: (value) {
                              return Get.find<MedAssistController>()
                                      .listOfAllMedicine!
                                      .any((element) =>
                                          element.medicineName != null &&
                                          element.medicineName == value)
                                  ? null
                                  : "Please Select an item from the dropdown!";
                            },
                            key: _observerWidget,
                            decoration:
                                decoration.copyWith(hintText: "Medicine Name"),
                          ),
                        ),
                        //!FLutter way to make a autocomplete system.
                        //!This both systems has mejor issues listed int the Flutter issue section.
                        /* LayoutBuilder(
                          builder: (context, constraints) {
                            return RawAutocomplete<String>(
                              textEditingController: medNameController,
                              focusNode: medicineNameNode,
                              optionsViewBuilder: (context, onSelected, options) {
                                // _findBoxPosition();
                                return Material(
                                  elevation: 4.0,
                                  child: SizedBox(
                                    width: _width,
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(8.0),
                                      itemCount: options.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final String option =
                                            options.elementAt(index);
                                        return Align(
                                          alignment: Alignment.topLeft,
                                          child: ListTile(
                                            title: Text(option),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              fieldViewBuilder: (context, textEditingController,
                                      focusNode, onFieldSubmitted) =>
                                 TextFormField(textCapitalization: TextCapitalization.none,
                                controller: textEditingController,
                                focusNode: focusNode,
                                key: _mainBox,
                                decoration:
                                    decoration.copyWith(hintText: "Medicine Name"),
                              ),
                              optionsBuilder: (textEditingValue) {
                                return ["Hellwo", "Hi"];
                              },
                            );
                          }
                        ), */
                        /* GetBuilder<MedAssistController>(builder: (controller) {
                          return Autocomplete<String>(
                            fieldViewBuilder: (context, textEditingController,
                                    focusNode, onFieldSubmitted) =>
                               TextFormField(textCapitalization: TextCapitalization.none,
                              controller: textEditingController,
                              focusNode: focusNode,
                              /* contextMenuBuilder: (context, editableTextState) {
                              return Container(
                                height: 50,
                                width: 50,
                                color: Colors.green,
                              );
                            }, */
                              key: _mainBox,
                              decoration: decoration.copyWith(
                                  hintText: "Medicine Name"),
                            ),
                            optionsBuilder: (textEditingValue) {
                              return controller.getMatchedMedicinesNameList(
                                  textEditingValue.text);
                            },
                            onSelected: (option) {
                              
                            },
                          );
                        }), */
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: brandNameController,
                          enabled: false,
                          decoration:
                              decoration.copyWith(hintText: "Brand Name"),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: indicationController,
                          enabled: false,
                          decoration:
                              decoration.copyWith(hintText: "Indication"),
                        ),
                        //const SizedBox(height: 18),
                        //Text(indication ?? "Indication"),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                "Shape",
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              flex: 6,
                              child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  decoration: decoration,
                                  value: shape,
                                  selectedItemBuilder: (context) {
                                    return iconShapeMap.entries
                                        .map(
                                          (shape) => Row(
                                            children: [
                                              SizedBox.square(
                                                dimension: 40,
                                                child: Image.asset(
                                                  shape.value,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  shape.key,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList();
                                  },
                                  items: iconShapeMap.entries
                                      .map(
                                        (shape) => DropdownMenuItem<String>(
                                          value: shape.key,
                                          child: Row(
                                            children: [
                                              SizedBox.square(
                                                dimension: 24,
                                                child: Image.asset(
                                                  shape.value,
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  shape.key,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  /*  items: shapes
                                      .map(
                                        (shape) => DropdownMenuItem<String>(
                                          value: shape,
                                          child: Text(shape),
                                        ),
                                      )
                                      .toList(), */
                                  onChanged: (value) {}),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text("Color"),
                            ),
                            SizedBox(width: 18),
                            Expanded(
                              flex: 6,
                              child: MaterialColorPicker(
                                allowShades: true,
                                selectedColor: selectedColor,
                                onColorChange: (value) {
                                  setState(() {
                                    selectedColor = value;
                                    log(selectedColor.hashCode
                                        .toRadixString(16));
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  // *Step 2
                  Step(
                    isActive: _index == 1,
                    title: Text(
                      "Instructions",
                      style: TextStyles.extraSmallBoldTextStyle(),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Variable Dose",
                            ),
                            const SizedBox(width: 12),
                            Switch(
                                value: variableDose,
                                onChanged: (value) {
                                  setState(() {
                                    variableDose = value;
                                  });
                                })
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Strength Supplied",
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: suppliedStrengthController,
                                decoration: decoration,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              unitName,
                              style: TextStyles.extraSmallBoldTextStyle()
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Strength to take",
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: strengthToTakeController,
                                decoration: decoration,
                                onChanged: (v) {
                                  setState(() {
                                    strengthToTakeController.text = v;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              unitName,
                              style: TextStyles.extraSmallBoldTextStyle()
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                              text: "Take    ",
                              style: const TextStyle(color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: "${strengthToTakeController.text}   ",
                                  style: TextStyles.extraSmallTextStyle()
                                      .copyWith(color: Colors.black),
                                ),
                                TextSpan(
                                  text: takeType,
                                  style: TextStyle(color: Colors.grey),
                                )
                              ]),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                "Timing",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                                flex: 4,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  decoration: decoration,
                                  value: timing,
                                  items: timings
                                      .map((timing) => DropdownMenuItem<String>(
                                          value: timing, child: Text(timing)))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      timing = value!;
                                      var index = timings.indexOf(value);
                                      index++;
                                      selectedTimingindex = index;
                                      log(selectedTimingindex.toString());
                                    });
                                  },
                                ))
                          ],
                        ),
                        SizedBox(height: 12),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (time != null) {
                                        timingOne.text = DateFormat.Hm().format(
                                            DateTime.now().copyWith(
                                                hour: time.hour,
                                                minute: time.minute));
                                      }
                                    },
                                    child: AbsorbPointer(
                                      absorbing: true,
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.none,
                                        controller: timingOne,
                                        decoration: decoration,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.square(
                                  dimension: 50,
                                  child: Image.asset(
                                      'assets/icons/dosageicon.webp'),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (time != null) {
                                        timingTwo.text = DateFormat.Hm().format(
                                            DateTime.now().copyWith(
                                                hour: time.hour,
                                                minute: time.minute));
                                      }
                                    },
                                    child: AbsorbPointer(
                                      absorbing: true,
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.none,
                                        controller: timingTwo,
                                        decoration: decoration,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.square(
                                  dimension: 50,
                                  child: Image.asset(
                                      'assets/icons/dosageicon.webp'),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (time != null) {
                                        timingThree.text = DateFormat.Hm()
                                            .format(DateTime.now().copyWith(
                                                hour: time.hour,
                                                minute: time.minute));
                                      }
                                    },
                                    child: AbsorbPointer(
                                      absorbing: true,
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.none,
                                        controller: timingThree,
                                        decoration: decoration,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.square(
                                  dimension: 50,
                                  child: Image.asset(
                                      'assets/icons/dosageicon.webp'),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (time != null) {
                                        timingFour.text = DateFormat.Hm()
                                            .format(DateTime.now().copyWith(
                                                hour: time.hour,
                                                minute: time.minute));
                                      }
                                    },
                                    child: AbsorbPointer(
                                      absorbing: true,
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.none,
                                        controller: timingFour,
                                        decoration: decoration,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.square(
                                  dimension: 50,
                                  child: Image.asset(
                                      'assets/icons/dosageicon.webp'),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (time != null) {
                                        timingFive.text = DateFormat.Hm()
                                            .format(DateTime.now().copyWith(
                                                hour: time.hour,
                                                minute: time.minute));
                                      }
                                    },
                                    child: AbsorbPointer(
                                      absorbing: true,
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.none,
                                        controller: timingFive,
                                        decoration: decoration,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.square(
                                  dimension: 50,
                                  child: Image.asset(
                                      'assets/icons/dosageicon.webp'),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                          ]..length = selectedTimingindex * 2,
                        ),
                        const SizedBox(height: 4),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                "Instructions",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 4,
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                decoration: decoration,
                                value: instruction,
                                items: instructions
                                    .map(
                                      (data) => DropdownMenuItem<String>(
                                        // enabled: data != instruction,
                                        value: data,
                                        child: Text(
                                          data,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          maxLines: 1,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    instruction = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // *Step 3
                  Step(
                    title: Text(
                      "Schedule",
                      style: TextStyles.extraSmallBoldTextStyle(),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text("Start Date"),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 4,
                              child: GestureDetector(
                                onTap: () async {
                                  String selectedDate =
                                      await getSelectedDateString(context,
                                          before: 60, after: 730);
                                  setState(() {
                                    startDayController.text = selectedDate;
                                  });
                                },
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: TextFormField(
                                    controller: startDayController,
                                    decoration: decoration,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text("End Date"),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 4,
                              child: GestureDetector(
                                onTap: () async {
                                  String selectedDate =
                                      await getSelectedDateString(context,
                                          before: 60, after: 730);
                                  setState(() {
                                    endDayeController.text = selectedDate;
                                  });
                                },
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: TextFormField(
                                    controller: endDayeController,
                                    decoration: decoration,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    value: "Every Day",
                                    groupValue: daySet,
                                    onChanged: (value) {
                                      setState(() {
                                        daySet = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  const Text("Every Day"),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    value: "Select Days",
                                    groupValue: daySet,
                                    onChanged: (value) {
                                      setState(() {
                                        daySet = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  const Text("Select Days"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (daySet == "Select Days") const SizedBox(height: 12),
                        if (daySet == "Select Days")
                          DaySelectorWidget(
                            selectedDays: selectedDays,
                            onTap: (value) {
                              setState(() {
                                if (selectedDays.contains(value)) {
                                  selectedDays.remove(value);
                                } else {
                                  selectedDays.add(value);
                                }
                                print(selectedDays.toString());
                              });
                            },
                          ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text("Quantity Supplied"),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: quantityController,
                                decoration: decoration,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // *Step 4
                  Step(
                    title: Text(
                      "Reminder Settings",
                      style: TextStyles.extraSmallBoldTextStyle(),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Medication Reminder",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(width: 12),
                              Switch(
                                value: medicationReminder,
                                onChanged: (value) {
                                  setState(() {
                                    medicationReminder = value;
                                    //remeberReminder = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Reminder   ",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 40,
                                width: 50.w,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: AbsorbPointer(
                                    absorbing: false,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      controller: medicationReminderController,
                                      decoration: decoration,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "    Minutes before.",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Pharmacy Refill Reminder",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(width: 12),
                              Switch(
                                value: pharmacyRefil,
                                onChanged: (value) {
                                  setState(() {
                                    pharmacyRefil = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Refill Reminder   ",
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 40,
                                width: 50.w,
                                child: GestureDetector(
                                  onTap: () async {
                                    //await showScrollingDatePicker(context);
                                  },
                                  child: AbsorbPointer(
                                    absorbing: false,
                                    child: TextFormField(
                                      textCapitalization:
                                          TextCapitalization.none,
                                      controller: pharmacyReminderController,
                                      decoration: decoration,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "    Days before.",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // *Final Step
                  Step(
                    title: Text(
                      "Confirmation",
                      style: TextStyles.extraSmallBoldTextStyle(),
                    ),
                    content: Column(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(14),
                  child: LinearProgressIndicator(
                    value: _index / 5,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DaySelectorWidget extends StatelessWidget {
  DaySelectorWidget({
    Key? key,
    required this.onTap,
    required this.selectedDays,
  }) : super(key: key);
  final List<String> days = [
    "Sat",
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
  ];

  final ValueChanged<String> onTap;
  final List<String> selectedDays;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: days
              .map(
                (day) => GestureDetector(
                  onTap: () => onTap(day),
                  child: ColoredBox(
                    color: selectedDays.contains(day)
                        ? Colors.green
                        : Colors.blue.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
