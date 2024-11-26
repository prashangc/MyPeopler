import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/helpers/storageHelper.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  initializeLocation() async {
    bool serviceEnabled;
    PermissionStatus backgroundServiceEnabled;
    PermissionStatus permissionGranted;
    bool notificationLocation;
    //LocationData _locationData;

    serviceEnabled = await Permission.location.serviceStatus.isEnabled;
    var data = await Permission.location.request();
    var data2 = await Permission.locationWhenInUse.request();
    PermissionStatus? data3;

    PermissionStatus status = await Permission.notification.status;

    if (!status.isGranted) {
      // The permission is not granted, request it.
      status = await Permission.notification.request();
    }

    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      try {
        if (int.parse(androidInfo.version.release) <= 11) {
          data3 = await Permission.storage.request();
        } else {
          data3 = PermissionStatus.denied;
        }
      } catch (e) {
        //for android version 8
        data3 = await Permission.storage.request();
      }
    }
    backgroundServiceEnabled = await Permission.locationAlways.request();

    StorageHelper.setLocationAccept(true);

    notificationLocation = await Geolocator.isLocationServiceEnabled();
    if (notificationLocation == false) {
      Get.offAllNamed(Routes.SECOND_IN_APP_DISCLOSURES, arguments: false);
      StorageHelper.setLocationAccept(false);
    } else if (notificationLocation == true) {
      StorageHelper.setLocationAccept(true);
    }

    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      log('${androidInfo.version.release}release version');
      try {
        if (int.parse(androidInfo.version.release) <= 11) {
          if (data3 == PermissionStatus.denied) {
            Get.offAllNamed(Routes.SECOND_IN_APP_DISCLOSURES);
            StorageHelper.setLocationAccept(false);
          }
        }
      } catch (e) {
        //for android version 8
        if (data3 == PermissionStatus.denied) {
          Get.offAllNamed(Routes.SECOND_IN_APP_DISCLOSURES);
          StorageHelper.setLocationAccept(false);
        }
      }
    }

    if (data == PermissionStatus.denied ||
        data2 == PermissionStatus.denied ||
        backgroundServiceEnabled == PermissionStatus.denied) {
      Get.offAllNamed(Routes.SECOND_IN_APP_DISCLOSURES);
      StorageHelper.setLocationAccept(false);
    }

    if (data == PermissionStatus.permanentlyDenied ||
        data2 == PermissionStatus.permanentlyDenied ||
        backgroundServiceEnabled == PermissionStatus.permanentlyDenied) {
      Get.offAllNamed(Routes.SECOND_IN_APP_DISCLOSURES);
      StorageHelper.setLocationAccept(false);
      openAppSettings();
    }

    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      try {
        if (int.parse(androidInfo.version.release) <= 11) {
          if (data3 == PermissionStatus.permanentlyDenied) {
            StorageHelper.setLocationAccept(false);
            openAppSettings();
          }
        }
      } catch (e) {
        //for android version 8
        if (data3 == PermissionStatus.permanentlyDenied) {
          StorageHelper.setLocationAccept(false);
          openAppSettings();
        }
      }
    }

    showAlertDialog(BuildContext context, String title, String message,
        Function() onPressed) {
      // set up the button
      Widget okButton = TextButton(
        onPressed: onPressed,
        child: const Text("OK"),
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    showCancelAlertDialog(BuildContext context, String title, String message,
        {required Function() onPressedOkButton,
        required Function() onPressedCancelButton}) {
      // set up the button
      Widget okButton = TextButton(
        onPressed: onPressedOkButton,
        child: const Text(
          "YES",
          style: TextStyle(color: Colors.green),
        ),
      );

      Widget cancelButton = TextButton(
        onPressed: onPressedCancelButton,
        child: const Text(
          "CANCEL",
          style: TextStyle(color: Colors.red),
        ),
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [okButton, cancelButton],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
