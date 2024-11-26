import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart' as bg;
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart' as lo;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:my_peopler/firebase_options.dart';
import 'package:my_peopler/location_call_back_handler.dart';
import 'package:my_peopler/src/app.dart';
import 'package:my_peopler/src/core/config/config.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

SharedPreferences? prefs;
Future<void> main() async {
  // Set up the error listener outside of the Flutter context
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
      fatal: true,
    );
  }).sendPort);

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(LOCAL_STORAGE);
  configureDependencies(Env.prod);
  await firebaseMethods();
  checkForUpdate();

  FlutterError.onError = (errorDetails) async {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  Workmanager().initialize(callbackDispatcher);

  BackgroundLocator.initialize();
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, irnputData) async {
    log(task);
    prefs = await SharedPreferences.getInstance();
    await prefs!.reload();

    var userId = prefs!.getInt("userId");
    var isCheckedIn = prefs!.getBool("isCheckedIn") ?? false;
    if (userId != null && isCheckedIn) {
      startBackgroundLocator(userId);
    } else {
      stopBackgroundLocator();
    }

    return Future.value(true);
  });
}

Future<bool> _checkLocationPermission() async {
  final locationStatus = await Permission.locationAlways.status;
  switch (locationStatus) {
    case PermissionStatus.denied:
    case PermissionStatus.restricted:
    case PermissionStatus.limited:
    case PermissionStatus.provisional:
    case PermissionStatus.permanentlyDenied:
      final newStatus = await Permission.locationAlways.request();
      if (newStatus == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    case PermissionStatus.granted:
      return true;
  }
}

Future<void> checkForUpdate() async {
  if (kIsWeb) {
    runApp(MyApp());
  } else {
    if (Platform.isAndroid) {
      try {
        AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
        log(updateInfo.toString());
        if (updateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          AppUpdateResult appUpdateResult =
              await InAppUpdate.performImmediateUpdate();
          if (appUpdateResult == AppUpdateResult.userDeniedUpdate) {
            exit(0);
            // runApp(MyApp());
          } else if (appUpdateResult == AppUpdateResult.success) {
            runApp(MyApp());
          }
        } else {
          runApp(MyApp());
        }
      } catch (e) {
        runApp(MyApp());
      }
    } else if (Platform.isIOS) {
      runApp(MyApp());
    }
  }
}

Future<void> firebaseMethods() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
    sound: true,
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  print("Handling a background message: ${message.messageId}");
}

Future<void> startBackgroundLocator(int userId) async {
  bool isLocationPermissionGranted = await _checkLocationPermission();
  if (isLocationPermissionGranted) {
    await _startLocator(userId);
  } else {
    // Open app setting
    await openAppSettings();
  }
}

Future<void> stopBackgroundLocator() async {
  var isAlreadyRunning = await BackgroundLocator.isServiceRunning();
  if (!isAlreadyRunning) return;
  await BackgroundLocator.unRegisterLocationUpdate();
}

Future<void> _startLocator(int userId) async {
  var isAlreadyRunning = await BackgroundLocator.isServiceRunning();
  if (isAlreadyRunning) return;

  lo.LocationAccuracy locationAccuracy = lo.LocationAccuracy.HIGH;
  double distanceFilter = 30;
  Map<String, dynamic> data = {"userId": userId};

  await BackgroundLocator.registerLocationUpdate(
    LocationCallbackHandler.callback,
    initCallback: LocationCallbackHandler.initCallback,
    initDataCallback: data,
    disposeCallback: LocationCallbackHandler.disposeCallback,
    iosSettings: IOSSettings(
        accuracy: locationAccuracy,
        distanceFilter: distanceFilter,
        stopWithTerminate: false,
        showsBackgroundLocationIndicator: true),
    autoStop: false,
    androidSettings: bg.AndroidSettings(
      accuracy: locationAccuracy,
      interval: 5,
      distanceFilter: distanceFilter,
      client: bg.LocationClient.google,
      androidNotificationSettings: bg.AndroidNotificationSettings(
        notificationChannelName: 'Location tracking',
        notificationTitle: 'Location Tracking',
        notificationMsg: 'Tracking location in background',
        notificationBigMsg: 'Background location tracking is on.',
        notificationIcon: 'launcher_icon',
        notificationIconColor: Colors.grey,
        notificationTapCallback: LocationCallbackHandler.notificationCallback,
      ),
    ),
  );
}
