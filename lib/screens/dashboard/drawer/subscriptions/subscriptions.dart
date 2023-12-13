import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wehealth/controller/subscription_controller/subscription_controller.dart';
import 'package:wehealth/screens/dashboard/notifications/notification_screen.dart';
import '../drawer_items.dart';
import 'browse_subscription_plans.dart';
import 'my_subsciptions.dart';
import 'transaction_history.dart';

class SubcriptionScreen extends StatefulWidget {
  const SubcriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubcriptionScreen> createState() => _SubcriptionScreenState();
}

class _SubcriptionScreenState extends State<SubcriptionScreen> {
  @override
  void initState() {
    super.initState();
    final controller = Get.put(SubscriptionController());
    controller.getSubscriptionPlans();
    controller.getUserPlans();
    controller.getUserTransactions();
    controller.getAllPlanFeatures();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const DrawerSide(),
       // drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
        appBar: AppBar(
          title: const Text("Subscriptions"),
        //    automaticallyImplyLeading: !Platform.isIOS,
        // leading: Platform.isIOS  
        // ?  IconButton(onPressed: (){
        //   Get.back();
        //   }, icon: const Icon(Icons.close),) 
        // : null,
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                Get.to(() => const NotificationScreen());
              },
              icon: const Icon(Icons.message),
            ),
          ],
          bottom: const TabBar(
              indicatorWeight: 3,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Text(
                    "Browse",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Tab(
                  icon: Text(
                    "My Subscriptions",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Tab(
                  icon: Text(
                    "Transaction History",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ]),
        ),
        body: const TabBarView(
          children: [
            BrowseTab(),
            MySubscriptionsTab(),
            TransactionHistoryTab(),
          ],
        ),
      ),
    );
  }
}
