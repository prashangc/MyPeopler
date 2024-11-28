import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:geolocator/geolocator.dart';
import 'package:my_peopler/custom_location_dto.dart';
import 'package:my_peopler/src/helpers/fileManager.dart';
import 'package:my_peopler/write_in_file.dart';

class LocationServiceRepository {
  static final LocationServiceRepository _instance =
      LocationServiceRepository._();

  LocationServiceRepository._();

  factory LocationServiceRepository() {
    return _instance;
  }

  static const String isolateName = 'LocatorIsolate';

  static Future<void> dispose() async {
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }

  static Future<List<String>> readLocationForUserId(int userId) async {
    String fileName = "$userId.txt";
    List<String> fileData = await FileManager.readFile(fileName);
    log("test test test $fileData");
    log("-----------------------");
    return fileData;
  }

  static Future<void> clearLocationDataForUserId(int userId) async {
    String fileName = "$userId.txt";
    await FileManager.clearFileData(fileName);
    log("FILE CLEARED");
    // await readLocationForUserId(userId);
  }

  static void backgroundLocationFetch(
    List<String> listOfLocalData,
  ) async {
    Position currentLocation = await Geolocator.getCurrentPosition();
    LocationDto? lastLocation =
        findLastLocationWithActualValue(listOfLocalData);
    if (lastLocation != null) {
      bool isDistMoreThan30m = isDistanceMoreThan30m(
        lastLat: lastLocation.latitude,
        lastLng: lastLocation.longitude,
        currentLat: currentLocation.latitude,
        currentLng: currentLocation.longitude,
      );
      if (isDistMoreThan30m) {
        WriteInFile.storeDataInFile();
      }
      DateTime lastDataTime =
          DateTime.fromMillisecondsSinceEpoch(lastLocation.time.toInt());
      DateTime currentTime = DateTime.now();
      Duration timeDifference = currentTime.difference(lastDataTime);

      if (timeDifference.inMinutes >= 5) {
        log("output -> Time exceeded 5 minuted so new added.");

        WriteInFile.storeDataInFile();
      }
    } else {
      log("last loc is null");
    }
  }

  static LocationDto? findLastLocationWithActualValue(
    List<String> listOfLocalData,
  ) {
    for (int i = listOfLocalData.length - 1; i >= 0; i--) {
      Map<String, dynamic> lastLocationMap = json.decode(listOfLocalData[i]);

      // Convert necessary fields to double or appropriate types
      lastLocationMap[Keys.ARG_LATITUDE] =
          double.tryParse(lastLocationMap[Keys.ARG_LATITUDE].toString()) ?? 0.0;
      lastLocationMap[Keys.ARG_LONGITUDE] =
          double.tryParse(lastLocationMap[Keys.ARG_LONGITUDE].toString()) ??
              0.0;
      lastLocationMap[Keys.ARG_ACCURACY] =
          double.tryParse(lastLocationMap[Keys.ARG_ACCURACY].toString()) ?? 0.0;
      lastLocationMap[Keys.ARG_ALTITUDE] =
          double.tryParse(lastLocationMap[Keys.ARG_ALTITUDE].toString()) ?? 0.0;
      lastLocationMap[Keys.ARG_SPEED] =
          double.tryParse(lastLocationMap[Keys.ARG_SPEED].toString()) ?? 0.0;
      lastLocationMap[Keys.ARG_SPEED_ACCURACY] = double.tryParse(
              lastLocationMap[Keys.ARG_SPEED_ACCURACY].toString()) ??
          0.0;
      lastLocationMap[Keys.ARG_HEADING] =
          double.tryParse(lastLocationMap[Keys.ARG_HEADING].toString()) ?? 0.0;
      lastLocationMap[Keys.ARG_TIME] =
          double.tryParse(lastLocationMap[Keys.ARG_TIME].toString()) ?? 0.0;

      LocationDto location = LocationDto.fromJson(lastLocationMap);

      if (location.latitude != 0.0) {
        return location;
      }
    }
    return null;
  }

  static bool isDistanceMoreThan30m({
    required double lastLat,
    required double lastLng,
    required double currentLat,
    required double currentLng,
  }) {
    double distance = Geolocator.distanceBetween(
      lastLat,
      lastLng,
      currentLat,
      currentLng,
    );
    log("output -> Distance between two location is = $distance");
    return distance > 30;
  }
}
