import 'dart:developer';

import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:wehealth/controller/msg_notification_controller/msg_notification_repository.dart';
import 'package:wehealth/controller/storage_controller.dart';
import 'package:wehealth/global/methods/methods.dart';
import 'package:wehealth/models/data_model/notification_model.dart';
import 'package:wehealth/models/data_model/user_sent_msg_wrapper.dart';

class MessageNotificationController extends GetxController {
  MessageNotificationController()
      : _repository = MessageNotificationRepository(
            storage: StorageController.instance());
  final MessageNotificationRepository _repository;

  UserMessagesWrapper _sentMessagesWrapper = UserMessagesWrapper();
  UserMessagesWrapper _recievedMessagesWrapper = UserMessagesWrapper();
  NotificationResponseWrapper _notificationResponse =
      NotificationResponseWrapper();

  List<NotificationModel>? get notifications =>
      _notificationResponse.notifications;

  NotificationModel? getNotificationById(int? id) {
    return notifications?.where((element) => element.id == id).firstOrNull;
  }

  List<MsgDetailsClass> get recievedMsges =>
      _recievedMessagesWrapper.msgesList ?? [];
  List<MsgDetailsClass> get sentMsges => _sentMessagesWrapper.msgesList ?? [];

  Map<int, List<MsgDetailsClass>> get sentMapByContactId {
    final mainMap = sentMsges.groupListsBy<int>((element) => element.toUserID!);
    for (List<MsgDetailsClass> list in mainMap.values) {
      list.sort(
        (a, b) {
          return b.timeStamp.compareTo(a.timeStamp);
        },
      );
    }
    return mainMap;
  }

  Map<int, List<MsgDetailsClass>> get recievedMapByContactId {
    final mainMap =
        recievedMsges.groupListsBy<int>((element) => element.fromUserID!);
    for (List<MsgDetailsClass> list in mainMap.values) {
      list.sort(
        (a, b) {
          return b.timeStamp.compareTo(a.timeStamp);
        },
      );
    }
    return mainMap;
  }

  Map<int, List<MsgDetailsClass>> get getFinalMap {
    return mergeMaps(sentMapByContactId, recievedMapByContactId,
        value: (recieved, sent) {
      recieved.addAll(sent);
      recieved.sort(
        (a, b) => b.timeStamp.compareTo(a.timeStamp),
      );
      return recieved;
    });
  }

  fetchUserSentMsgList() async {
    try {
      UserMessagesWrapper? response = await _repository.getUserSentMsges();
      if (response != null && response.msgesList != null) {
        _sentMessagesWrapper = response;
      }
      update();
    } catch (error) {
      log("Error While fetching fetchUserSentMsgList ${error.toString()}");
    }
  }

  fetchUserRecievedMsgList() async {
    try {
      UserMessagesWrapper? response = await _repository.getUserRecievedMsges();
      if (response != null && response.msgesList != null) {
        _recievedMessagesWrapper = response;
      }
      update();
    } catch (error) {
      log("Error While fetching fetchUserRecievedMsgList ${error.toString()}");
    }
  }

  fetchNotificationMessages() async {
    try {
      NotificationResponseWrapper? response =
          await _repository.getUserNotifications();
      if (response != null && response.notifications != null) {
        _notificationResponse = response;
      }
      update();
    } catch (error) {
      log("Error While fetching fetchNotificationMessages ${error.toString()}");
    }
  }

  Future<bool> postUserMsg(int contactId, String msg, String subject) async {
    try {
      SendMsgModel? response =
          await _repository.postUserMessage(contactId, msg, subject);
      if (response != null) {
        await fetchUserSentMsgList();
        return true;
      }
      return false;
    } catch (error) {
      log("Error While posting postUserMsg ${error.toString()}");
      return false;
    }
  }

  updateNotificationImportance(int id) async {
    if (getNotificationById(id)!.isImportant == 0) {
      getNotificationById(id)!.isImportant = 1;
    } else {
      getNotificationById(id)!.isImportant = 0;
    }
    update();

    final res = await _repository.postUserNotificationImportance(id);
    if (res ?? false) {
      showToast('Notification updated!', Get.context);
    } else {
      showToast('Error updating notification!', Get.context);
    }
    // await fetchNotificationMessages();
  }

  deleteUserNotification(int id) async {
    final res = await _repository.postUserNotificationDelete(id);
    if (res ?? false) {
      showToast('Notification Deleted!', Get.context);
    } else {
      showToast('Error deleting notification!', Get.context);
    }
    await fetchNotificationMessages();
  }
}
