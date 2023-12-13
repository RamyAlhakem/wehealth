import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/subscription_controller/subscription_controller.dart';
import 'package:wehealth/models/data_model/subscription_transactions_wrapper.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';
import '../../../../global/styles/text_styles.dart';

class TransactionHistoryTab extends StatelessWidget {
  const TransactionHistoryTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionController>(builder: (controller) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: controller.userTransactions?.length ?? 0,
        itemBuilder: (context, index) => TransactionHistoryTile(
            transactionData: controller.userTransactions![index]),
      );
    });
  }
}

class TransactionHistoryTile extends StatelessWidget {
  const TransactionHistoryTile({
    Key? key,
    required this.transactionData,
  }) : super(key: key);

  final SubscriptionTransModel transactionData;

  @override
  Widget build(BuildContext context) {
    final transDate = stringDateWithTZ.parse(transactionData.transcdate ?? "");
    String transDateString = DateFormat.yMd().format(transDate);

    return GetBuilder<SubscriptionController>(builder: (controller) {
      String planName = controller.subscriptionPlans
              ?.firstWhereOrNull(
                (element) => element.id == transactionData.planid,
              )
              ?.planName ??
          "Family Plan";

      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
          child: SizedBox(
            height: 90,
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
                        "RM ${transactionData.transactamount ?? 0}",
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
                      child: Text(
                        "Transaction Date:",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        transDateString,
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
                      child: Text(
                        "Status:",
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        transactionData.responseDesc ?? "Unknown",
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
