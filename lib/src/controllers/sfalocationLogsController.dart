import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/handle_local_notification.dart';
import 'package:my_peopler/location_service_repo.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/baseResponse.dart';
import 'package:my_peopler/src/models/sfa/sfa_location_data.dart';
import 'package:my_peopler/src/repository/repository.dart';
import 'package:my_peopler/write_in_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SfaLocationLogsController extends GetxController {
  final ProfileRepository _profileRepo = getIt<ProfileRepository>();
  bool isLoading = false;
  bool freezeApp = false;
  SharedPreferences? prefs;

  sfaLocationLogs(List<Map<String, dynamic>> logs) async {
    isLoading = true;
    update();
    var res = await _profileRepo.sfaLocationLogs(logs);
    isLoading = false;
    if (res.status == 'success') {
      freezeApp = false;

      prefs?.setBool('sync_location_logs', false); // ?
    } else if (res.status == 'error') {
      freezeApp = true;
      // freezeApp = false;

      prefs?.setBool('sync_location_logs', true);
    }
    update();
    return res;
  }

  enableBackgroundTracking() async {
    if (StorageHelper.liveTracking == "1") {
      StorageHelper.enableBackgroundLocation(true);
      if (Platform.isIOS) {
        FlutterBackgroundService().invoke("setAsBackground");
        Fluttertoast.showToast(msg: 'Location Tracking enabled.');
      } else {
        FlutterBackgroundService().invoke("setAsBackground");
        Fluttertoast.showToast(msg: 'Location Tracking enabled.');
      }
    } else if (StorageHelper.liveTracking == "") {
      Fluttertoast.showToast(
          msg: 'Logout and re-login to enable location tracking');
    } else {
      Fluttertoast.showToast(
          msg:
              'Location Tracking not enabled by admin. Please contact your admin if you want to enable location tracking.');
    }
  }

  convertListStringToSfaLocationModel({required bool? isCheckIn}) async {
    if (isCheckIn != null) {
      if (isCheckIn) {
        await WriteInFile.storeDataInFile();
      }
    }
    var data = await LocationServiceRepository.readLocationForUserId(
        StorageHelper.userId!);
    log(data.toString());
    if (data.isNotEmpty) {
      var logs = data.map((input) {
        return SfaLocationData.fromJson(jsonDecode(input)).toJson();
      }).toList();
      log(logs.toString());
      // Fluttertoast.showToast(msg: logs.toString());
      BaseResponse responseData = await sfaLocationLogs(logs);

      ///
      ///Clear local file data when data sync is done.
      ///
      if (responseData.status == 'success') {
        if (isCheckIn != null) {
          if (isCheckIn) {
            enableBackgroundTracking();
          } else {
            //checkout
            HandleLocalNotification.service.invoke("stopService");
            await LocationServiceRepository.clearLocationDataForUserId(
                StorageHelper.userId!);
          }
        } else {
          await LocationServiceRepository.clearLocationDataForUserId(
              StorageHelper.userId!);
          WriteInFile.storeDataInFile();
        }
      }
      return responseData;
    } else {
      // return sfaLocationLogs([]);
      log(data.toString());
      // Show message , No data left in local to sync.
      Fluttertoast.showToast(msg: "No data left in local to sync.");
    }
  }

  getSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    await prefs!.reload();
    if (prefs?.getBool('sync_location_logs') == true) {
      freezeApp = true;
    }
    update();
  }
}
