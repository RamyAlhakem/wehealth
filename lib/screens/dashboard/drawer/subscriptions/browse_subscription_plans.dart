import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/subscription_controller/subscription_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/subscription_plan_model.dart';
import '../../../../http_cleint/app_config.dart';
import '../../widgets/subscription_plan_details_popup.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({Key? key}) : super(key: key);

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (controller) {
      return ListView.builder(
        itemCount: controller.subscriptionPlans?.length ?? 0,
        itemBuilder: (context, index) => SubscriptionPlanTile(
          subscriptionPlan: controller.subscriptionPlans![index],
        ),
      );
    });
  }
}

class SubscriptionPlanTile extends StatelessWidget {
  const SubscriptionPlanTile({
    Key? key,
    required this.subscriptionPlan,
  }) : super(key: key);

  final SubscriptionPlanModel subscriptionPlan;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.network(
                      AppConfig.imageBaseUrl +
                          (subscriptionPlan.photopath ?? ""),
                      fit: BoxFit.cover,
                      alignment: const Alignment(0.0, -0.20),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            subscriptionPlan.planName ?? "",
                            style: TextStyles.extraSmallBoldTextStyle(),
                          ),
                          Text(
                            "RM ${subscriptionPlan.price ?? "e"}",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) =>
                                PlanDetailsScreen(planModel: subscriptionPlan),
                          );
                        },
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "View Plan".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
