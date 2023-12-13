import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/med_assist_controller/med_assist_controller.dart';
import 'package:wehealth/controller/msg_notification_controller/msg_notification_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/user_sent_msg_wrapper.dart';
import 'package:wehealth/screens/dashboard/notifications/care_plan_tab.dart';
import 'package:wehealth/screens/dashboard/notifications/msg_page.dart';

import '../drawer/drawer_items.dart';
import 'notifications_tab.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(MessageNotificationController()).fetchUserRecievedMsgList();
    Get.put(MessageNotificationController()).fetchUserSentMsgList();
    Get.put(MedAssistController()).fetchMedicationTaskWrapper();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Platform.isAndroid ? const DrawerSide() : null,
        appBar: AppBar(
          title: const Text("Notifications"),
          automaticallyImplyLeading: !Platform.isIOS,
          leading: Platform.isIOS
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                )
              : null,
          bottom: TabBar(
              indicatorWeight: 3,
              indicatorColor: Colors.white,
              labelStyle: TextStyle(fontSize: 10.sp),
              tabs: const [
                Tab(
                  icon: Text(
                    "Messages",
                  ),
                ),
                Tab(
                  icon: Text(
                    "Notifications",
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
                Tab(
                  icon: Text(
                    "Care Plan",
                  ),
                ),
              ]),
        ),
        body: const TabBarView(
          children: [
            NotificationMsgesTab(),
            NotificationsTab(),
            NotificationCarePlanTab(),
          ],
        ),
      ),
    );
  }
}

class NotificationMsgesTab extends StatelessWidget {
  const NotificationMsgesTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageNotificationController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchUserSentMsgList();
            await controller.fetchUserRecievedMsgList();
          },
          child: ListView.builder(
            itemCount: controller.getFinalMap.values.length,
            itemBuilder: (context, index) => UserContactMsgListTile(
                msgData: controller.getFinalMap.values.toList()[index].first),
          ),
        ),
      );
    });
  }
}

class UserContactMsgListTile extends StatelessWidget {
  final MsgDetailsClass msgData;
  Completer<bool> accepted = Completer();

  UserContactMsgListTile({Key? key, required this.msgData}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(msgData.id),
      confirmDismiss: (direction) async {
        return await accepted.future;
      },
      onUpdate: (details) {
        if (accepted.isCompleted) {
          accepted = Completer();
        }
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                'Are you sure you want to delete this message?',
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () {
                accepted.complete(false);
              },
              child: Text(
                'No',
                style: TextStyles.extraSmallBoldTextStyle(),
              ),
            ),
            TextButton(
              onPressed: () {
                accepted.complete(true);
              },
              child: Text(
                'Yes',
                style: TextStyles.extraSmallBoldTextStyle().copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      child: ListTile(
        onTap: () {
          Get.to(
            () => MessagesPage(
              contactId: msgData.isMe ? msgData.toUserID! : msgData.fromUserID!,
              name: "${msgData.firstName} ${msgData.lastName}",
            ),
          );
          log(msgData.datetime.toString());
          log(msgData.id.toString());
        },
        title: Row(
          children: [
            Expanded(
              child: Text(
                "${msgData.firstName} ${msgData.lastName}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.extraSmallBoldTextStyle(),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              DateFormat('yyyy-M-dd hh:mm:ss')
                  .format(msgData.timeStamp)
                  .toString(),
              style: TextStyles.customText(8.sp, FontWeight.normal)
                  .copyWith(color: Colors.blue),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                msgData.details ?? "",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(
                Icons.star_border_rounded,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
