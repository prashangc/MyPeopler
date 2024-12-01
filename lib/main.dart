import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:my_peopler/firebase_options.dart';
import 'package:my_peopler/handle_local_notification.dart';
import 'package:my_peopler/location_service_repo.dart';
import 'package:my_peopler/my_shared_pref.dart';
import 'package:my_peopler/src/app.dart';
import 'package:my_peopler/src/core/config/config.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HandleLocalNotification.startBackgroundService();
  await GetStorage.init(LOCAL_STORAGE);
  configureDependencies(Env.prod);
  checkForUpdate();
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

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  // DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually
  /// OPTIONAL when use custom notification
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsForegroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
    // WakelockPlus.toggle(enable: false);
  });

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      log('OUTPUT --> BG WORKING');
      // MessageHelper.success("listening");
      var prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt("userId");
      if (userId != null) {
        List<String> listOfLocalData =
            await LocationServiceRepository.readLocationForUserId(userId);
        if (listOfLocalData.isNotEmpty) {
          try {
            Position currentLocation = await Geolocator.getCurrentPosition();
            LocationServiceRepository.backgroundLocationFetch(
              listOfLocalData,
              currentLocation,
              userId: userId,
            );
          } catch (_) {
            LocationServiceRepository.backgroundLocationFetch(
              listOfLocalData,
              null,
              userId: userId,
            );
          }
        } else {
          log('OUTPUT --> BG WORKING BUT FILE IS EMPTY SO DO NOTHINGS');
        }
      }
    }
    // try {
    //   Position? position = await Geolocator.getCurrentPosition();
    //   HandleLocalNotification.showNotification(
    //     title: "Bg service running successfully.",
    //     body: "Listening Lat -> ${position.latitude}",
    //   );
    // } catch (_) {}
  });
}
