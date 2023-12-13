import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/http_cleint/api_clients.dart';
import 'package:wehealth/models/data_model/plan_features_wrapper.dart';
import 'package:wehealth/models/data_model/subscription_plan_model.dart';
import 'package:wehealth/models/data_model/subscription_transactions_wrapper.dart';
import 'package:wehealth/models/data_model/user_plans_model.dart';

import '../../http_cleint/app_config.dart';

@immutable
class SubscriptionRepository {
  const SubscriptionRepository({
    required this.storage,
  });
  final StorageController storage;

  final String baseUrl = AppConfig.baseUrl;

  Future<SubscriptionPlanWrapper?> getSubscriptionPlans() async {
    String url =
        "$baseUrl/getsubscriptionplan?token=${storage.userToken}&userid=${storage.userId}";

    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        SubscriptionPlanWrapper wrapper =
            SubscriptionPlanWrapper.fromJson(response);
        return wrapper;
      } else {
        log("GetSubscrptionPlan Status => ${response['error']}!");
        return null;
      }
    } catch (error) {
      log("Error While fetching GetSubscrptionPlan ${error.toString()}");
      return null;
    }
  }

  Future<PlanFeaturesWrapper?> getAllPlanFeatures() async {
    String url =
        "$baseUrl/retrievePlanFeatures?token=${storage.userToken}&userid=${storage.userId}";

    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        PlanFeaturesWrapper wrapper = PlanFeaturesWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getAllPlanFeatures Status => ${response['error']}!");
        return null;
      }
    } catch (error, trace) {
      log("Error While fetching getAllPlanFeatures ${error.toString()}",
          stackTrace: trace);
      return null;
    }
  }

  Future<UserPlansWrapper?> getUserPlans() async {
    String url =
        "$baseUrl/getUserPlan?token=${storage.userToken}&userid=${storage.userId}";

    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        UserPlansWrapper wrapper = UserPlansWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUserPlan Status => ${response['error']}!");
        return null;
      }
    } catch (error, trace) {
      log("Error While fetching getUserPlan ${error.toString()}",
          stackTrace: trace);
      return null;
    }
  }

  Future<SubscriptionTransactionsWrapper?> getUserTransactions() async {
    String url =
        "$baseUrl/getPaymentTranscation?token=${storage.userToken}&userid=${storage.userId}";

    try {
      var response = await ApiClients.getJson(url);
      if (response['error'] == 0) {
        SubscriptionTransactionsWrapper wrapper =
            SubscriptionTransactionsWrapper.fromJson(response);
        return wrapper;
      } else {
        log("getUserTransactions Status => ${response['error']}!");
        return null;
      }
    } catch (error, trace) {
      log("Error While fetching getUserTransactions ${error.toString()}",
          stackTrace: trace);
      return null;
    }
  }
}
