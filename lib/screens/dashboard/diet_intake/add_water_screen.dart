import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/dietary_controller/dietary_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/global/widgets/ios_close_appbar.dart';
import '../../../controller/dietary_controller/model/water_inatake_model.dart';
import '../widgets/horizontal_text_field.dart';
import '../widgets/scrolling_date_picker.dart';


class AddWaterScreen extends StatefulWidget {
  const AddWaterScreen({Key? key}) : super(key: key);

  @override
  State<AddWaterScreen> createState() => _AddWaterScreenState();
}

class _AddWaterScreenState extends State<AddWaterScreen> {
  final pageColor = Colors.green.shade700;

  final dayFormat = DateFormat("EEE yyyy-MM-d k:mm");
  final recordTimeCon = TextEditingController();
  final intakeSizeCon = TextEditingController();

  String selected = "Select";
  String? finalallySelected;
  final List<String> fluidType = [
    "Select",
    "Plain water / Air kosong",
    "Milo / Milo",
    "Coffee / Kopi",
    "Tea / Teh",
    "Soup / Sup",
    "Cola / Cola", 
    "Green Tea / Teh hijau", 
    "Energy Drink / Minuman tenaga", 
    "Milk Shake / Susu kocak", 
    "Juice / Jus",
  ];

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapper(
      title: "Water",
      appBarColor: pageColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: SizedBox(
                  height: 200,
                  child: Image.asset(
                    "assets/icons/food_water.webp",
                    color: pageColor,
                  ),
                ),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              GestureDetector(
                onTap: () async {
                  DateTime? date = await showBoxyScrollingPicker(context);
                  log(date.toString());
                  if (date != null) {
                    log("Selected Date ${date.toString()}");
                    setState(() {
                      recordTimeCon.text = dayFormat.format(date);
                    });
                  }
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: HorizontalTextFormField(
                    controller: recordTimeCon,
                    title: "Date :",
                  ),
                ),
              ),
              const Divider(color: Colors.grey, thickness: 1),
              Row(
                children: [
                  Expanded(flex: 4, child: Text("Fluid Type: ", style: TextStyles.extraSmallText14BStyle().copyWith(color: Colors.black87,),)),
                  Expanded(
                    flex: 6,
                    child: SizedBox(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          isExpanded: true,
                          value: selected,
                          alignment: Alignment.center,
                          items: fluidType
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              finalallySelected = value!;
                              log("finalallySelected 2 @=> $finalallySelected");
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(flex: 4, child: Text("Intake : ", style: TextStyles.extraSmallText14BStyle().copyWith(color: Colors.black87),),),
                  Expanded(
                    flex: 6,
                    child: TextFormField(
                    keyboardType: TextInputType.number,
                      controller: intakeSizeCon,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffix: Text("ML", style: TextStyles.extraSmallText14BStyle().copyWith(color: Colors.black87), textAlign: TextAlign.center),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 150.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: pageColor,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        onPressed: () async {
                          Get.find<StorageController>()
                              .addWaterIntakeHistory(SingleWaterWaterIntakeData(
                            date: dayFormat.parse(recordTimeCon.text),
                            waterLevel: double.parse(intakeSizeCon.text),
                          ));
                          final waterData = WaterIntakeData(
                            drinkname: finalallySelected,
                            drinksize: double.parse(intakeSizeCon.text),
                            recorddatetime: DateTime.now().toString(),
                            userid: Get.find<StorageController>().userId,
                          );
                          Get.find<DietaryController>().addWaterIntake(data: waterData);
                       
                       
                        },
                        child: Text(
                          "Save",
                          style: TextStyles.smallTextBoldStyle()
                              .copyWith(color: pageColor),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
