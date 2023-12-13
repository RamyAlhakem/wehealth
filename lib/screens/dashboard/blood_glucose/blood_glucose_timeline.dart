import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/blood_glucose_controller/blood_glucose_controller.dart';
import 'package:wehealth/controller/user_devices_controller/user_devices_controller.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/blood_glucose_data_fetch_wrapper.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/add_doctor_appt.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_iconed_data_tiles.dart';
import 'package:wehealth/screens/dashboard/widgets/horizontal_textfield.dart';
import 'package:wehealth/screens/dashboard/widgets/overlay_loading_indicator.dart';
import 'package:wehealth/screens/dashboard/widgets/timeline_date_widget.dart';
import 'manual_blood_glucose_screen.dart';

class BloodGlucoseTimelineTab extends StatelessWidget {
  const BloodGlucoseTimelineTab({
    Key? key,
  }) : super(key: key);
  final baseColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BloodGlucoseController>(builder: (controller) {
      return Column(
        children: [
          //------- COMMON Portion --------//
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: HorizontalIconedDataTileAdd(
              iconPath: "assets/icons/mnu_bg_l.webp",
              data:
                  "${(controller.getBloodGlucoseDataByType("BeforeMeal").lastOrNull?.glucoseLevel ?? 0).toPrecision(2)}",
              unit: "mmol/L",
              baseColor: baseColor,
              seconderyWidget: Get.find<UserDevicesController>()
                      .hasBloodGlucoseDevice
                  ? Image.asset(
                      "assets/icons/devices/bluetooth_glucose_disconnect.webp")
                  : const SizedBox(),
              onAddClick: () {
                Get.to(() => const ManualBloodGlucoseWidget());
              },
            ),
          ),
          //------- COMMON Portion --------//
          Expanded(
            child: CustomScrollView(
              slivers: [
                for (MapEntry<DateTime, List<BloodGlucoseData>> item
                    in controller.getTimelineFormat().entries.toList()
                        .reversed) ...[
                  SliverToBoxAdapter(
                    child: TimelineDateWidget(date: item.key),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final sortedByTime = item.value.reversed.toList();
                        return BloodGlucoseTimelineDataTile(
                          data: sortedByTime[index],
                        );
                      },
                      childCount: item.value.length,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    });
  }
}

class BloodGlucoseTimelineDataTile extends StatelessWidget {
  const BloodGlucoseTimelineDataTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final BloodGlucoseData data;

  Color get getColorFromData {
    switch (data.getBloodGlucoseSattus) {
      case RangeChecker.low:
        return Colors.redAccent;
      case RangeChecker.mid:
        return Colors.green;
      case RangeChecker.high:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormat = DateFormat("hh:mm");
    return InkWell(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) => BloodGlucoseEditPopUp(data: data),
        );
      },
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 100,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade700,
            ),
            bottom: BorderSide(
              color: Colors.grey.shade700,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: getColorFromData,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${data.glucoseLevel ?? ""}",
                          style: TextStyles.extraSmallBoldTextStyle()
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "mmol/L",
                        style: TextStyle(color: Colors.grey.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            timeFormat.format(data.recordDate),
                            style: TextStyles.extraSmallText12BStyle()
                                .copyWith(color: Colors.grey.shade700),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          data.typeToName,
                          style: TextStyles.extraSmallText14BStyle(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data.notes ?? "",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BloodGlucoseEditPopUp extends StatefulWidget {
  const BloodGlucoseEditPopUp({
    Key? key,
    required this.data,
  }) : super(key: key);

  final BloodGlucoseData data;

  @override
  State<BloodGlucoseEditPopUp> createState() => _BloodGlucoseEditPopUpState();
}

class _BloodGlucoseEditPopUpState extends State<BloodGlucoseEditPopUp> {
  late final TextEditingController _glucoseLevelCon;
  late final TextEditingController _noteCon;
  late String selectedType;
  @override
  void initState() {
    super.initState();
    _glucoseLevelCon =
        TextEditingController(text: "${widget.data.glucoseLevel ?? ""}");
    _noteCon = TextEditingController(text: widget.data.notes);
    selectedType = widget.data.mealType ?? "BeforeBed";
  }

  String typeToName(String mealType) {
    switch (mealType) {
      case "BeforeBed":
        return "Before Bed";
      case "AfterMeal":
        return "After Meal";
      case "BeforeMeal":
        return "Before Meal";
      case "Fasting":
        return "Fasting";
      default:
        return "Other";
    }
  }

  List<String> typeList = [
    "BeforeBed",
    "AfterMeal",
    "BeforeMeal",
    "Fasting",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        constraints: const BoxConstraints(
          maxWidth: 350,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                ),
                child: SizedBox(
                  height: 40.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: 32,
                            child: Image.asset(
                              "assets/icons/mnu_bg_l.webp",
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Center(
                            child: Text(
                              "Edit Record",
                              style: TextStyles.smallTextStyle().copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 32,
                          child: IconButton(
                            color: Colors.white,
                            padding: EdgeInsets.zero,
                            iconSize: 28,
                            onPressed: () async {
                              final bool? res = await showDialog<bool>(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    const ConfirmDeleteDialogue(),
                              );
                              if (res == true) {
                                await Get.showOverlay(
                                  loadingWidget:
                                      const OverlayLoadingIndicator(),
                                  asyncFunction: () async =>
                                      await Get.find<BloodGlucoseController>()
                                          .deleteUserBloodGlucoseData(
                                    data: widget.data,
                                  ),
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: HorizontalTextField(
                  controller: _glucoseLevelCon,
                  title: "Blood Glucose",
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey.shade700,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: HorizontalTitledDropdown<String>(
                  title: "Meal Type",
                  options: typeList.map((e) => typeToName(e)).toList(),
                  selectedItem: typeToName(selectedType),
                  onChange: (value) {
                    setState(() {
                      selectedType = value!.replaceAll(" ", "");
                    });
                  },
                  titleStyle: TextStyles.extraSmallTextStyle(),
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey.shade700,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: HorizontalTextField(
                  controller: _noteCon,
                  maxLines: 3,
                  title: "Notes",
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey.shade700,
              ),
              InkWell(
                onTap: () async {
                  await Get.showOverlay(
                      loadingWidget: const OverlayLoadingIndicator(),
                      asyncFunction: () async {
                        await Get.find<BloodGlucoseController>()
                            .updateUserBloodGlucoseData(
                                id: widget.data.id.toString(),
                                glucoseLevel: _glucoseLevelCon.text,
                                mealType: selectedType,
                                note: _noteCon.text);
                      });
                },
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "UPDATE",
                      style: TextStyles.extraSmallText14BStyle()
                          .copyWith(color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmDeleteDialogue extends StatelessWidget {
  const ConfirmDeleteDialogue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 6),
      actionsOverflowButtonSpacing: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber,
            size: 80,
            color: Colors.orange,
          ),
          const SizedBox(height: 6),
          Text(
            "Are you sure?",
            style: TextStyles.smallTextBoldStyle(),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "You won't be able to recover this record.",
              textAlign: TextAlign.center,
              style: TextStyles.extraSmallTextStyle(),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            Get.back<bool>(result: true);
          },
          child: const Text(
            "Yes, Delete this record!",
          ),
        ),
      ],
    );
  }
}
