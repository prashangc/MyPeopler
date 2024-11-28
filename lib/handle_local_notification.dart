import 'dart:math' as math;

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_peopler/main.dart';

class HandleLocalNotification {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final FlutterBackgroundService service = FlutterBackgroundService();

  static void startBackgroundService() async {
    await createAndroidNotificationChannel();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,

        // auto start service
        autoStart: true,
        isForegroundMode: false,
        notificationChannelId: 'high_importance_channel',
        initialNotificationTitle: 'Location Tracking',
        initialNotificationContent: 'App is tracking your location',
        foregroundServiceNotificationId: 888,
        foregroundServiceTypes: [AndroidForegroundType.location],
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,

        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,

        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
  }

  static Future<NotificationDetails> createAndroidNotificationChannel() async {
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
        await createAndroidNotificationChannel();
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
