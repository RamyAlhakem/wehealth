import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wehealth/controller/msg_notification_controller/msg_notification_controller.dart';
import 'package:wehealth/global/styles/text_styles.dart';
import 'package:wehealth/models/data_model/notification_model.dart';
import 'package:wehealth/screens/dashboard/drawer/home/appointment/appt_constants.dart';
import 'package:wehealth/screens/dashboard/notifications/notification_detail.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageNotificationController>(
      builder: (notificationController) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: notificationController.notifications?.length ?? 0,
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              height: 1,
              color: Colors.black,
              thickness: 1,
            ),
          ),
          itemBuilder: (context, index) => NotificationListTile(
            data: notificationController.notifications![index],
            controller: notificationController,
          ),
        ),
      ),
    );
  }
}

class NotificationListTile extends StatelessWidget {

  NotificationListTile({Key? key, required this.data, required this.controller}) : super(key: key);
  final MessageNotificationController controller;
  final NotificationModel data;
  Completer<bool> accepted = Completer();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(data.id),
      confirmDismiss: (direction) async {
        final res = await accepted.future;
        if (res) {
          controller.deleteUserNotification(data.id!);
        }
        return res;
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
                'Are you sure you want to delete this notification?',
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    data.username ?? "Username",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.extraSmallBoldTextStyle(),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  DateFormat('yyyy-M-dd hh:mm')
                      .format(stringDateWithTZ.parse(data.datetime ?? "?/?"))
                      .toString(),
                  style: TextStyles.customText(8.sp, FontWeight.normal)
                      .copyWith(color: Colors.blue),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          ListTile(
            onTap: () {
              Get.to(
                () => NotificationDetailScreen(notificationModel: data),
              );
            },
            title: Text(data.subject ?? "Subject?",
                style: TextStyles.extraSmallText12BStyle()),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.details ?? "Details?",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.customText(10.sp, FontWeight.normal)),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            trailing: Column(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    controller.updateNotificationImportance(data.id!);
                  },
                  icon: (controller.getNotificationById(data.id)!.isImportant ==
                          0)
                      ? const Icon(Icons.star_border_rounded)
                      : const Icon(
                          Icons.star_rate_rounded,
                          color: Colors.amber,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
