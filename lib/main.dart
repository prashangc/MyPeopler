import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart' as bg;
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart' as lo;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:my_peopler/firebase_options.dart';
import 'package:my_peopler/handle_local_notification.dart';
import 'package:my_peopler/location_call_back_handler.dart';
import 'package:my_peopler/my_shared_pref.dart';
import 'package:my_peopler/src/app.dart';
import 'package:my_peopler/src/core/config/config.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    try {
      await PreferenceHelper.init();
      // Simulate task processing
      Position locData = await Geolocator.getCurrentPosition();

      PreferenceHelper.storeStringToDevice(
        tokenKey: "test1",
        tokenValue: locData.latitude.toString(),
      );
      PreferenceHelper.storeStringToDevice(
        tokenKey: "test2",
        tokenValue: "random",
      );

      HandleLocalNotification.showNotification(
        title: "Test input data = ${inputData!['name']}",
        body: "Test body",
      );

      // Simulate a conditional outcome
      if (task == "retryTask") {
        // Return false for retry
        return Future.value(false);
      }

      // Return true for success
      return Future.value(true);
    } catch (e) {
      // Log the error or handle it appropriately
      print("Error in task: $e");

      // Return error outcome
      return Future.error("Task failed due to an error: $e");
    }
  });
}

SharedPreferences? prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init(LOCAL_STORAGE);
  configureDependencies(Env.prod);
  await _checkLocationPermission();
  checkForUpdate();
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
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

Future<void> stopBackgroundLocator() async {
  var isAlreadyRunning = await BackgroundLocator.isServiceRunning();
  if (!isAlreadyRunning) return;
  await BackgroundLocator.unRegisterLocationUpdate();
}

Future<void> startLocator(int userId) async {
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
        notificationBigMsg: 'Background Location tracking is on.',
        notificationIcon: 'launcher_icon',
        notificationIconColor: Colors.grey,
        notificationTapCallback: LocationCallbackHandler.notificationCallback,
      ),
    ),
  );
}
