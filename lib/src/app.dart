import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_peopler/location_service_repo.dart';
import 'package:my_peopler/src/binding/initialBinding.dart';
import 'package:my_peopler/src/helpers/fileManager.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/resources/theme_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/views/others/noInternetView.dart';
import 'package:my_peopler/src/views/second_in_app_disclourse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Position? locationData;
  SharedPreferences? prefs;
  int? userId;

  @override
  void initState() {
    fetchLocation();
    super.initState();
  }

  fetchLocation() async {
    locationData = await Geolocator.getCurrentPosition();
    var prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    userId = prefs.getInt("userId");
    setState(() {});
  }

  writeDataInTextFile() async {
    String fileName = "$userId.txt";

    Map<String, dynamic> errorMessage = {
      'latitude': 0.0,
      'longitude': 0.0,
      'accuracy': 0.0,
      'altitude': 0.0,
      'speed': 0.0,
      'speed_accuracy': 0.0,
      'heading': 0.0,
      'time': '2024-06-17 04:00:00',
      'is_mocked': false,
      'provider': '',
    };

    FileManager.writeContentInFile(fileName, json.encode(errorMessage));

    List<String> list =
        await LocationServiceRepository.readLocationForUserId(userId!);
    log("length tst = ${list.length}");
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyPeopler',
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      initialBinding: InitialBinding(),
      initialRoute: getInitialRoute(),
      getPages: AppPages.routes,
      builder: (context, child) {
        return StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            final result = snapshot.data;
            switch (result) {
              case ConnectivityResult.none:
                return NoInternetView();
              default:
                return StreamBuilder(
                    stream: Geolocator.getServiceStatusStream(),
                    builder: (context, snapshot) {
                      final result = snapshot.data;
                      switch (result) {
                        // Enter the log location off in lat, long
                        case ServiceStatus.disabled:
                          Fluttertoast.showToast(
                              msg: 'Background service triggered.');
                          writeDataInTextFile();
                          return SecondInAppDisclourse(
                            hasButton: false,
                          );
                        case null:
                          return child!;
                        case ServiceStatus.enabled:
                          return child!;
                        default:
                          return child!;
                      }
                    });
            }
          },
        );
      },
    );
  }

  String getInitialRoute() {
    if (StorageHelper.locationAccept == false) {
      return Routes.IN_APP_DISCLOSURES;
    } else if (StorageHelper.isEmployee == false) {
      return Routes.CUSTOMER_NAV_VIEW;
    } else {
      return Routes.INITIAL;
    }
  }
}

checkLocationPermission() async {
  LocationPermission locationPermission = await Geolocator.checkPermission();
  if (locationPermission == LocationPermission.always) {
    await _startInitialPage();
  } else {
    locationPermission = await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.always) {
      await _startInitialPage();
    } else {
      await _showDisclosurePage();
    }
  }
}

_startInitialPage() async {
  StorageHelper.setLocationAccept(true);
  if (StorageHelper.isEmployee == false) {
    Get.offAllNamed(Routes.CUSTOMER_NAV_VIEW);
  } else {
    Get.offAllNamed(Routes.INITIAL);
  }
}

_showDisclosurePage() async {
  StorageHelper.setLocationAccept(false);
  Get.offAllNamed(
    Routes.IOS_IN_APP_DISCLOSURES,
  );
}
