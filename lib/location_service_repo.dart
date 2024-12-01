import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:math' as math;
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
    return fileData;
  }

  static Future<void> clearLocationDataForUserId(int userId) async {
    String fileName = "$userId.txt";
    await FileManager.clearFileData(fileName);
    log("FILE CLEARED");
    // await readLocationForUserId(userId);
  }

  static bool shouldCallMethod = false;

  static void monitorLocationService() {
    Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      if (status == ServiceStatus.enabled) {
        log('OUTPUT --> LISTENING LOCATION STATUS ENABLED');
        shouldCallMethod = false;
      } else {
        log('OUTPUT --> LISTENING LOCATION STATUS DISABLED');
        shouldCallMethod = true;
      }
    });
  }

  static void backgroundLocationFetch(
    List<String> listOfLocalData,
    Position? currentLocation, {
    required int? userId,
  }) {
    monitorLocationService();
    LocationDto? lastLocationWithData = findLastLocationWithActualValue(
      listOfLocalData: listOfLocalData,
      findLastElement: false,
    );

    LocationDto? lastLocationWithNullOrActualData =
        findLastLocationWithActualValue(
      listOfLocalData: listOfLocalData,
      findLastElement: true,
    );
    // if (currentLocation == null) {
    //   if (lastLocationWithNullOrActualData == null ||
    //       lastLocationWithNullOrActualData.latitude != 1111111.11) {
    //     WriteInFile.writeStaticDataInTextFile();
    //   }
    // }
    if (lastLocationWithNullOrActualData != null) {
      /// THIS IS REQUIRED FOR
      /// WHEN IN TEXTFILE THERE IS 11111.11 LAT VALUE
      /// AT LAST INDEX
      /// IN EVERY 5 MIN IT WILL GIVE ADDING
      /// 11111.11 VALUE SO THAT
      /// EVEN USER CLOSES LOCATION
      /// WE WILL KNOW THAT STILL IN 5 MIN
      /// HE/SHE HASN'T OPENED LOCATION
      // DateTime lastDateTime = DateTime.fromMillisecondsSis
      DateTime lastDateTime =
          DateTime.parse(lastLocationWithNullOrActualData.time);
      DateTime currentTime = DateTime.now();
      Duration timeDifference = currentTime.difference(lastDateTime);
      // log("OUTPUT --> TIME DIFF IS ${timeDifference.inSeconds}");
      if (timeDifference.inMinutes >= 1) {
        // log('OUTPUT --> STATIC LOCATION ADDED TO FILE');
        WriteInFile.writeStaticDataInTextFile();
      }
    }
    if (shouldCallMethod) {
      log('OUTPUT --> ADDED STATIC LOCATION ADDED TO FILE');
      WriteInFile.writeStaticDataInTextFile();
      shouldCallMethod = false;
    }
    if (lastLocationWithData != null) {
      if (currentLocation != null) {
        bool isSpeedHigh = checkSpeed(speed: currentLocation.speed);
        double distanceThreshold = isSpeedHigh ? 100 : 30;
        bool isDistMoreThan30mOr100m = isDistanceMoreThan30mOr100m(
          lastLat: lastLocationWithData.latitude,
          lastLng: lastLocationWithData.longitude,
          currentLat: currentLocation.latitude,
          currentLng: currentLocation.longitude,
          distanceThreshold: distanceThreshold,
        );
        if (isDistMoreThan30mOr100m) {
          log('OUTPUT --> ACTUAL LOCATION ADDED TO FILE ( BECAUSE MORE THAN 30m )');
          WriteInFile.storeDataInFile(
            position: currentLocation,
            userId: userId,
          );
        }
      }
    }
  }

  static bool checkSpeed({required double speed}) {
    if (speed == 0.0) {
      return false;
    }
    double speedKmh = speed * 3.6;
    log("speed = $speed");
    return speedKmh > 10;
  }

  static LocationDto? findLastLocationWithActualValue({
    required List<String> listOfLocalData,
    required bool findLastElement,
  }) {
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
      // lastLocationMap[Keys.ARG_TIME] =
      //     double.tryParse(lastLocationMap[Keys.ARG_TIME].toString()) ?? 0.0;
      // lastLocationMap[Keys.ARG_TIME] =
      //     lastLocationMap[Keys.ARG_TIME].toString();

      LocationDto location = LocationDto.fromJson(lastLocationMap);

      if (location.latitude != 1111111.11) {
        return location;
      } else {
        if (findLastElement) {
          return location;
        }
      }
    }
    return null;
  }

  static bool isDistanceMoreThan30mOr100m({
    required double lastLat,
    required double lastLng,
    required double currentLat,
    required double currentLng,
    required double distanceThreshold,
  }) {
    double distance = Geolocator.distanceBetween(
      lastLat,
      lastLng,
      currentLat,
      currentLng,
    );
    // var p = 0.017453292519943295;
    // var c = math.cos;
    // var a = 0.5 -
    //     c((currentLat - lastLat) * p) / 2 +
    //     c(lastLat * p) *
    //         c(currentLat * p) *
    //         (1 - c((currentLng - lastLng) * p)) /
    //         2;
    // double distance = 1000 * 12742 * math.asin(math.sqrt(a));
    // double distance =
    //     calculateDistance(lastLat, lastLng, currentLat, currentLng);
    log('OUTPUT --> DISTANCE BETWEEN TWO LOCATION IS $distance');
    return currentLat != lastLat && distance > distanceThreshold;
  }

  static double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    const double earthRadius = 6371.0;
    double dLat = _degreesToRadians(endLatitude - startLatitude);
    double dLon = _degreesToRadians(endLongitude - startLongitude);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(startLatitude)) *
            math.cos(_degreesToRadians(endLatitude)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    // Convert the distance from kilometers to meters
    return earthRadius * c * 1000;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180;
  }
}
