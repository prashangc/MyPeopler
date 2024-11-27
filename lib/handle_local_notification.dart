import 'dart:math' as math;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HandleLocalNotification {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<NotificationDetails> createAndroidNotificationChannel(
      {required String title}) async {
    AndroidNotificationChannel androidNotificationChannel =
        const AndroidNotificationChannel(
      "high_importance_channel",
      "high_importance_channel",
      description: "high_importance_channel",
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.deleteNotificationChannel("high_importance_channel");
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      math.Random.secure().nextInt(100000).toString(),
      "high_importance_channel",
      playSound: true,
      icon: "@drawable/launcher_icon",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    DarwinNotificationDetails iosPlatformChannelSpecifics =
        const DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosPlatformChannelSpecifics,
    );
    return notificationDetails;
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    NotificationDetails notificationDetails =
        await createAndroidNotificationChannel(title: title);
    _flutterLocalNotificationsPlugin.show(
      1,
      title,
      body,
      notificationDetails,
      payload: null,
    );
  }

  static void initLocalNotifications() async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@drawable/launcher_icon');

    var initializationSetting =
        InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: onTapLocalNotification,
    );
  }

  static void onTapLocalNotification(
      NotificationResponse notificationResponse) async {
    // navigate
  }
}
