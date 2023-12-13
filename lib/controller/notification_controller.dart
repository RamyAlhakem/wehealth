// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wehealth/controller/auth_controller/auth_controller.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationController {
  NotificationController._sharedInstance();
  static final NotificationController _shared =
      NotificationController._sharedInstance();
  factory NotificationController({required SharedPreferences prefs}) {
    _shared.pref = prefs;
    _shared.initializeNotifications();
    return _shared;
  }

  late SharedPreferences pref;
  PushNotification pushNotification = PushNotification();
  LocalNotification localNotification = LocalNotification();

  initializeNotifications() async {
    await pushNotification.initialize(pref);
    await localNotification.initialize(pref);
    pushNotification.setForegroundListener(
        localNotification: localNotification);
    pushNotification.setBackgroundListener();
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class PushNotification {
  FirebaseMessaging? messaging;
  SharedPreferences? pref;

  initialize(SharedPreferences prefs) async {
    messaging = FirebaseMessaging.instance;
    pref = prefs;
    NotificationSettings settings = await messaging!.requestPermission(
      alert: true,
      badge: true,
      criticalAlert: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      messaging?.getInitialMessage();
      await saveFcmToken();
      await setTokenListener();
    } else {
      log('### User permission status: ${settings.authorizationStatus}');
    }
  }

  saveFcmToken({String? sendedToken}) async {
    String token = sendedToken ?? await messaging?.getToken() ?? "";
    log("##FCM token: $token");
    pref!.setString("fcmToken", token);

    // *** Other server uploading methods!
    await Get.find<AuthController>().updateDeviceId(token);
  }

  setTokenListener() async {
    messaging!.onTokenRefresh.listen((fcmToken) async {
      await saveFcmToken(sendedToken: fcmToken);
    }).onError((err) {
      // Error getting token.
      err.printError();
    });
  }

  setForegroundListener({required LocalNotification localNotification}) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // *** Handle the message notification!
      log("##User just got a notification!");
      if (message.notification != null) {
        localNotification.showPushedNotification(message);
      }
    });
  }

  setBackgroundListener() async {
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      log("##Clicked on a notification on the background!");
      //*** This is where you check the Notification and do the work when the app is in the Background or closed!
    });
  }
}

class LocalNotification {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  NotificationDetails? currentNotificationDetail;
  SharedPreferences? pref;
  int _notificationCount = 0;

  int getNotificationCount() => _notificationCount;
  setCount(int orderId) {
    _notificationCount = orderId;
    pref!.setInt("OrderId", _notificationCount);
  }

  int useCount() {
    int id = _notificationCount;
    setCount(id++);
    return id;
  }

  initialize(SharedPreferences prefs) {
    pref = prefs;
    tz.initializeTimeZones();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const androidSetting = AndroidInitializationSettings('@mipmap/main_icon');
    const iosSetting = DarwinInitializationSettings();
    setImportantNotification();
    const initializationsSettings =
        InitializationSettings(android: androidSetting, iOS: iosSetting);
    flutterLocalNotificationsPlugin!.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        //*** This is where you check the payload and do the work when the app is in the foreground!
        log("##Clicked!");
      },
    );
    _notificationCount = pref!.getInt("orderId") ?? 0;
  }

  setRepeatingNotification(DateTime when, Duration gap) {
    flutterLocalNotificationsPlugin!.periodicallyShow(
        useCount(),
        "Check",
        "This is ${useCount()}",
        RepeatInterval.everyMinute,
        currentNotificationDetail!,
        androidAllowWhileIdle: true,
        payload: "This is the story!",
        );
    flutterLocalNotificationsPlugin!.cancel(1);
    flutterLocalNotificationsPlugin!.zonedSchedule(
      useCount(),
        "Take your medicine please!", "Hey Osustho Rogi!", tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5),), currentNotificationDetail!,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time
        );
  }

  setImportantNotification() {
    currentNotificationDetail = NotificationDetails(
      android: AndroidNotificationDetails(
        'iheal-umch.chieff',
        'WeHealth',
        number: _notificationCount,
        playSound: true,
        importance: Importance.max,
        priority: Priority.max,
      ),
      iOS: DarwinNotificationDetails(
        badgeNumber: _notificationCount,
        presentBadge: true,
        presentAlert: true,
      ),
    );
  }

  showTextNotification(String title, String body, String? payload) async {
    await flutterLocalNotificationsPlugin!.show(
      useCount(),
      title,
      body,
      currentNotificationDetail,
      payload: payload ?? "",
    );
  }

  showPushedNotification(RemoteMessage pushedNotification) async {
    if (pushedNotification.notification?.title != null) {
      await showTextNotification(pushedNotification.notification!.title!,
          pushedNotification.notification!.body!, null);
    } else {
      //* Manage Data *//
    }
  }
}
