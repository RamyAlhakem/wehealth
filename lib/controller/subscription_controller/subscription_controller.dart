import 'dart:developer';

import 'package:get/get.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/controller/subscription_controller/subscription_repository.dart';
import 'package:wehealth/models/data_model/plan_features_wrapper.dart';
import 'package:wehealth/models/data_model/subscription_plan_model.dart';
import 'package:wehealth/models/data_model/subscription_transactions_wrapper.dart';
import 'package:wehealth/models/data_model/user_plans_model.dart';

class SubscriptionController extends GetxController {
  final SubscriptionRepository _repository =
      SubscriptionRepository(storage: Get.find<StorageController>());

  SubscriptionPlanWrapper _subscriptionPlanWrapper = SubscriptionPlanWrapper();
  List<SubscriptionPlanModel>? get subscriptionPlans =>
      _subscriptionPlanWrapper.subscriptionPlans;

  UserPlansWrapper _userPlansWrapper = UserPlansWrapper();
  List<UserPlanClass>? get userPlans => _userPlansWrapper.userPlans;

  SubscriptionTransactionsWrapper _transactionsWrapper =
      SubscriptionTransactionsWrapper();
  List<SubscriptionTransModel>? get userTransactions =>
      _transactionsWrapper.transactionsList;

  PlanFeaturesWrapper _featuresWrapper = PlanFeaturesWrapper();
  List<PlanFeatureModel>? get allPlanFeatures => _featuresWrapper.allFeatures;

  getSubscriptionPlans() async {
    try {
      SubscriptionPlanWrapper? response =
          await _repository.getSubscriptionPlans();
      if (response != null && response.subscriptionPlans != null) {
        _subscriptionPlanWrapper = response;
      }
      update();
    } catch (error) {
      log("Error while updating getSubscriptionPlans => $error");
    }
  }

  getAllPlanFeatures() async {
    try {
      PlanFeaturesWrapper? response = await _repository.getAllPlanFeatures();
      if (response != null && response.allFeatures != null) {
        _featuresWrapper = response;
      }
      update();
    } catch (error) {
      log("Error while updating getAllPlanFeatures => $error");
    }
  }

  getUserPlans() async {
    try {
      UserPlansWrapper? response = await _repository.getUserPlans();
      if (response != null && response.userPlans != null) {
        _userPlansWrapper = response;
      }
      update();
    } catch (error) {
      log("Error while updating getUserPlans => $error");
    }
  }

  getUserTransactions() async {
    try {
      SubscriptionTransactionsWrapper? response =
          await _repository.getUserTransactions();
      if (response != null && response.transactionsList != null) {
        _transactionsWrapper = response;
      }
      update();
    } catch (error) {
      log("Error while updating getUserTransactions => $error");
    }
  }
}
