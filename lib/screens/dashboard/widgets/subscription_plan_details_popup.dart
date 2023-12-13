import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/subscription_controller/subscription_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/plan_features_wrapper.dart';
import 'package:wehealth/models/data_model/subscription_plan_model.dart';

class PlanDetailsScreen extends StatelessWidget {
  const PlanDetailsScreen({
    Key? key,
    required this.planModel,
  }) : super(key: key);

  final SubscriptionPlanModel planModel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.easeIn,
      insetPadding: const EdgeInsets.all(18),
      child: GetBuilder<SubscriptionController>(builder: (controller) {
        final List<PlanFeatureModel> featuresList;
        if (controller.allPlanFeatures != null) {
          featuresList = controller.allPlanFeatures!
              .where(
                (element) => element.planid == planModel.id,
              )
              .toList();
        } else {
          featuresList = [];
        }
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                child: Column(
                  children: [
                    Text(
                      planModel.planName ?? "Family Plan",
                      style: TextStyles.normalTextBoldStyle(),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      text: TextSpan(
                          text: "RM ${planModel.price}",
                          style: TextStyles.extraLargeTextStyle().copyWith(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: " /${planModel.frequency}",
                              style: TextStyles.extraSmallTextStyle(),
                            ),
                          ]),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade400,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: const Text(
                        "10%",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: featuresList
                            .map((featureModel) =>
                                Text("* ${featureModel.featurename}"))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "GET THE PLAN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
