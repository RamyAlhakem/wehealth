import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/subscription_controller/subscription_controller.dart';
import 'package:wehealth/models/data_model/user_plans_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';
import '../../../../global/styles/text_styles.dart';

class MySubscriptionsTab extends StatelessWidget {
  const MySubscriptionsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (controller) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: controller.userPlans?.length ?? 0,
        itemBuilder: (context, index) =>
            MySubscriptionsTile(userPlan: controller.userPlans![index]),
      );
    });
  }
}

class MySubscriptionsTile extends StatelessWidget {
  const MySubscriptionsTile({
    Key? key,
    required this.userPlan,
  }) : super(key: key);

  final UserPlanClass userPlan;

  @override
  Widget build(BuildContext context) {
    final subDate = stringDateWithTZ.parse(userPlan.subscriptiondate ?? "");
    final expDate = stringDateWithTZ.parse(userPlan.expirydate ?? "");
    String subDateString = DateFormat.yMd().format(subDate);
    String expDateString = DateFormat.yMd().format(expDate);
    return GetBuilder<SubscriptionController>(builder: (controller) {
      String planName = controller.subscriptionPlans
              ?.firstWhereOrNull(
                (element) => element.id == userPlan.planid,
              )
              ?.planName ??
          "Family Plan";
      int price = controller.subscriptionPlans
              ?.firstWhereOrNull(
                (element) => element.id == userPlan.planid,
              )
              ?.price ??
          0;
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
          child: SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        planName,
                        style: TextStyles.smallTextBoldStyle()
                            .copyWith(color: Colors.grey.shade800),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "RM " + price.toString(),
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Auto Renew"),
                        onChanged: (value) {},
                        value: (userPlan.autorenew == 1),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Auto Bill"),
                        onChanged: (value) {},
                        value: (userPlan.autoBill == 1),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        "Subscription Date:",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        subDateString,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        "Expir Date:",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        expDateString,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
