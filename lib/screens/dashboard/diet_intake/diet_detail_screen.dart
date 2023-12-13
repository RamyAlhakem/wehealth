import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wehealth/controller/dietary_controller/dietary_controller.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/constants/functions_extensions.dart';
import 'package:wehealth/screens/dashboard/diet_intake/add_food_screen.dart';
import 'package:wehealth/screens/dashboard/diet_intake/add_water_screen.dart';
import 'package:wehealth/screens/dashboard/diet_intake/diet_food_manual.dart';
import 'package:wehealth/screens/dashboard/diet_intake/diet_settings_screen.dart';
import 'package:wehealth/screens/dashboard/diet_intake/fluid_intake_details_record_screen.dart';
import 'package:wehealth/screens/dashboard/diet_intake/food_details_record_screen.dart';
import 'package:wehealth/screens/dashboard/diet_intake/nutritionist_scale_screen.dart';
import 'package:wehealth/screens/dashboard/widgets/custom_gauge.dart';
import 'package:wehealth/screens/dashboard/widgets/image_tile_button.dart';
import '../../../global/widgets/ios_close_appbar_float.dart';
import '../widgets/image_list_tile.dart';

class DietIntakeDetailScreen extends StatefulWidget {
  const DietIntakeDetailScreen({Key? key}) : super(key: key);

  @override
  State<DietIntakeDetailScreen> createState() => _DietIntakeDetailScreenState();
}

class _DietIntakeDetailScreenState extends State<DietIntakeDetailScreen> {
  final pageColor = Colors.green.shade700;

  @override
  Widget build(BuildContext context) {
    return IosScaffoldWrapperWithFloat(
      appBarColor: pageColor,
      title: "Dietary Intake",
      faButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        backgroundColor: pageColor,
        closeManually: false,
        closeDialOnPop: true,
        renderOverlay: false,
        spacing: 12,
        spaceBetweenChildren: 12,
        onOpen: () async {},
        children: [
          SpeedDialChild(
            child: CircleAvatar(
              backgroundColor: pageColor,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset("assets/icons/addfoodicon.webp"),
              ),
            ),
            backgroundColor: pageColor,
            label: 'Food Manual',
            onTap: () async {
              Get.to(() => const DietFoodManualScreen());
            },
          ),
          SpeedDialChild(
            child: CircleAvatar(
              backgroundColor: pageColor,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset("assets/icons/addfoodicon.webp"),
              ),
            ),
            backgroundColor: pageColor,
            label: 'Diet Settings',
            onTap: () {
              Get.to(() => const DietSettingsScreen());
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.emoji_nature_outlined,
              color: Colors.white,
            ),
            backgroundColor: pageColor,
            label: 'Nutritionist Scale',
            onTap: () {
              Get.to(() => const NutritionistScaleScreen());
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.white,
            ),
            backgroundColor: pageColor,
            label: 'Scan Barcode',
            onTap: () {
              // Get.to(() => const AddDoctorAppointment());
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.water_drop_rounded,
              color: Colors.white,
            ),
            backgroundColor: pageColor,
            label: 'Add Water',
            onTap: () {
              Get.to(() => const AddWaterScreen());
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.food_bank_rounded,
              color: Colors.white,
            ),
            backgroundColor: pageColor,
            label: 'Add Food',
            onTap: () {
              Get.to(() => const AddFoodScreen());
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.description_rounded,
              color: Colors.white,
            ),
            backgroundColor: pageColor,
            label: 'Create Report',
            onTap: () {
              // Get.to(() => const AddDoctorAppointment());
            },
          ),
          SpeedDialChild(
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
              ),
              label: 'Take Picture',
              backgroundColor: pageColor,
              onTap: () async {
                // Get.to(() => const AddClinicAppointment());
                final image = await fetchImage(context);
              }),
        ],
      ),
      body: GetBuilder<DietaryController>(builder: (controller) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150.h,
                    child: Image.asset(
                      "assets/icons/dietary_intake.png",
                      width: 150,
                    ),
                  ),
                ],
              ),
            ),
            ImageListTile(
              image: "assets/images/foodbackgrounddashboard.webp",
              data: "-",
              unit: "kcal",
              subtitle: "Total Energy Requirement: 0 Kcal",
              textColor: Colors.green,
              leadingBorderColor: Colors.black12,
              onTap: () {
                Get.to(() => const FoodDetailsRecordScreen());
              },
            ),
            const SizedBox(height: 8),
            ImageListTile(
              image: "assets/images/waterbackgrounddashboard.webp",
              data:
                  "${controller.todaysWaterIntakeList.lastOrNull?.drinksize ?? 0.0}",
              unit: "ml",
              subtitle: "Total Fluid Intake: ${controller.todaysTotal} ml",
              textColor: Colors.green,
              leadingBorderColor: Colors.black12,
              onTap: () {
                Get.to(() => const FluidIntakeDetailsRecordScreen());
              },
            ),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ImageTileButton(
                    title: "Breakfast",
                    image: "assets/images/breakfast.webp",
                    color: Colors.green,
                    onTap: () {
                      Get.to(() => const AddFoodScreen());
                    },
                  ),
                  ImageTileButton(
                    title: "Morning Tea",
                    image: "assets/icons/food_breakfast.webp",
                    color: Colors.green,
                    onTap: () {
                      Get.to(() => const AddFoodScreen());
                    },
                  ),
                  ImageTileButton(
                    title: "Lunch",
                    image: "assets/images/lunchicon.webp",
                    color: Colors.green,
                    onTap: () {
                      Get.to(() => const AddFoodScreen());
                    },
                  ),
                  ImageTileButton(
                    title: "Tea Break",
                    image: "assets/icons/teabreak.webp",
                    color: Colors.green,
                    onTap: () {
                      Get.to(() => const AddFoodScreen());
                    },
                  ),
                  ImageTileButton(
                    title: "Dinner",
                    image: "assets/images/dinner.webp",
                    color: Colors.green,
                    onTap: () {
                      Get.to(() => const AddFoodScreen());
                    },
                  ),
                  ImageTileButton(
                    title: "Supper",
                    image: "assets/images/snackicon.webp",
                    color: Colors.green,
                    onTap: () {
                      Get.to(() => const AddFoodScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
