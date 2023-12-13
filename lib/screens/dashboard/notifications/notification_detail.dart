import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/notification_model.dart';
import 'package:wehealth/screens/dashboard/drawer/drawer_items.dart';

class NotificationDetailScreen extends StatefulWidget {
  const NotificationDetailScreen({Key? key, required this.notificationModel})
      : super(key: key);
  final NotificationModel notificationModel;
  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  String? parsedDetail;
  String? parsedDate;
  // 2022-04-20T01:29:29.000Z
  DateFormat initialDate = DateFormat("yyyy-MM-ddThh:mm:ss");
  DateFormat formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss");

  @override
  void initState() {
    super.initState();
    parsedDetail = widget.notificationModel.details!
        .replaceAll(" <br> ", "\n")
        .replaceAll("<br>", "\n");

    log("Unformatted Date => ${widget.notificationModel.datetime!}");
    DateTime date = initialDate.parse(widget.notificationModel.datetime!);
    parsedDate = formattedDate.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
         automaticallyImplyLeading: !Platform.isIOS,
        leading: Platform.isIOS  
        ?  IconButton(onPressed: (){
          Get.back();
          }, icon: const Icon(Icons.close),) 
        : null,
      ),
      drawer:  Platform.isAndroid  ? const DrawerSide()  : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.notificationModel.subject!,
              style: TextStyles.normalTextBoldStyle()
                  .copyWith(color: Colors.grey.shade800),
            ),
            const SizedBox(height: 5),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(height: 5),
            Text(
              "From:    ${widget.notificationModel.username}",
              style: TextStyles.extraSmallTextStyle(),
            ),
            const SizedBox(height: 5),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(height: 5),
            Text(
              "Date:    $parsedDate",
              style: TextStyles.extraSmallTextStyle(),
            ),
            const SizedBox(height: 5),
            const Divider(
              thickness: 1.5,
            ),
            const SizedBox(height: 5),
            Text(
              "$parsedDetail",
              style: TextStyles.extraSmallTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
