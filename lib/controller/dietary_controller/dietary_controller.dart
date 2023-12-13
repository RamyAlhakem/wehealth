// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:get/get.dart';
import 'package:wehealth/controller/dietary_controller/model/water_inatake_model.dart';
import 'package:wehealth/global/methods/methods.dart';

import '../../screens/dashboard/diet_intake/fluid_intake_details_record_screen.dart';
import '../storage_controller.dart';
import 'dietary_repository.dart';
import 'model/food_suggestion_model.dart';

class DietaryController extends GetxController {
  final DietaryRepository _repository = DietaryRepository(
    storage: Get.find<StorageController>(),
  );

  FoodSuggestionResponse? _suggestedFoodList = FoodSuggestionResponse();
  List<FoodSuggestionData> get suggestedFoodList =>
      _suggestedFoodList?.data ?? [];

  GetWaterIntakeModel? waterIntakeData;
  List<WaterIntakeData> get waterIntakeDataList => waterIntakeData?.data ?? [];
  List<WaterIntakeData> todaysWaterIntakeList = [];

  double get todaysTotal => todaysWaterIntakeList.fold(0, (previousValue, element) => previousValue + (element.drinksize ?? 0));

  searchFood(String query) async {
    try {
      FoodSuggestionResponse? response =
          await _repository.getFoodSuggestion(query);
      if (response?.data != null) {
        _suggestedFoodList = response;
      }
      update();
    } catch (e, s) {
      log(
        "Error While fetching searchFood ${e.toString()}",
        error: e,
        stackTrace: s,
      );
    }
  }

  addWaterIntake({required WaterIntakeData data}) async {
    final response = await _repository.postWaterIntake(data: data);
    print("mukta @==> response");
    print(response['error']);

    if (response['error'] == 0) {
      showToast(response['authResponse'], Get.context);
      Get.to(() => const FluidIntakeDetailsRecordScreen());
    }
  }

  getWaterIntake() async {
    try {
      final today = DateTime.now();
      var response = await _repository.getUserWaterIntake();
      waterIntakeData = response;
      todaysWaterIntakeList = todaysWaterIntakeList
          .where(
            (element) => (today.day == element.time.day &&
                today.month == element.time.month &&
                today.year == element.time.year),
          )
          .toList();
      update();
    } catch (e, s) {
      log("Error While fetching searchFood ${e.toString()}");
    }
  }
}
