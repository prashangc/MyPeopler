import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator_2/keys.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_peopler/src/helpers/fileManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationServiceRepository {
  static final LocationServiceRepository _instance =
      LocationServiceRepository._();

  LocationServiceRepository._();

  factory LocationServiceRepository() {
    return _instance;
  }

  static const String isolateName = 'LocatorIsolate';

  Future<void> initCallback(Map<String, dynamic> params) async {
    // Set up the error listener outside of the Flutter context
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
        fatal: true,
      );
    }).sendPort);

    FlutterError.onError = (errorDetails) async {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  Future<void> dispose() async {
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }

  Future<void> callback(LocationDto locationDto) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    var userId = prefs.getInt("userId");
    if (userId != null) {
      await storeDataLocally(locationDto, userId);
    }
  }

  Future<void> storeDataLocally(LocationDto locationDto, int userId) async {
    var locationDtoJson = locationDto.toJson();
    String fileName = "$userId.txt";

    // Check if the file exists
    File file = File(fileName);
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    // Check if the file exists
    // File file = File(fileName);
    // Get the app's document directory (for emulator or real device path)
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String filePath = "${appDocDir.path}/$fileName";
    // File file = File(filePath);

    if (!isLocationServiceEnabled) {
      // If location services are off, write a message instead of the location data
      String message = "Location has been turned off.";
      FileManager.writeContentInFile(fileName, message);
    } else {
      if (await file.exists()) {
        // Read the last stored location from the file
        String lastLocationJson = await file.readAsString();
        Map<String, dynamic> lastLocationMap = json.decode(lastLocationJson);
        LocationDto lastLocation = LocationDto.fromJson(lastLocationMap);

        // Calculate distance between the last location and the new location
        double distance = Geolocator.distanceBetween(
          lastLocation.latitude,
          lastLocation.longitude,
          locationDto.latitude,
          locationDto.longitude,
        );

        // If distance is more than 30 meters, store the new location
        if (distance > 30) {
          FileManager.writeContentInFile(
              fileName, json.encode(locationDtoJson));
        }
      } else {
        // If the file does not exist, store the new location
        FileManager.writeContentInFile(fileName, json.encode(locationDtoJson));
      }
    }

    // Send the data through Isolate
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(locationDtoJson);
  }

  // Future<void> storeDataLocally(
  //     LocationDto locationDto, int userId) async {
  //   var locationDtoJson = locationDto.toJson();

  //   final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
  //   send?.send(locationDtoJson);

  //   String fileName = "$userId.txt";
  //   FileManager.writeContentInFile(fileName, json.encode(locationDtoJson));

  //   // var startingLogJson = jsonDecode(locationList.first);
  //   // var startingLog = SfaLocationData.fromJson(startingLogJson);

  //   // var daysbetw = daysBetween(startingLog.time, DateTime.now());
  //   // if (daysbetw >= 5) {
  //   //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //   await prefs.setBool('sync_location_logs', true);
  //   // }
  // }

  static Future<List<String>> readLocationForUserId(int userId) async {
    String fileName = "$userId.txt";
    List<String> fileData = await FileManager.readFile(fileName);

    return fileData;
  }

  static Future<void> clearLocationDataForUserId(int userId) async {
    String fileName = "$userId.txt";
    await FileManager.clearFileData(fileName);
    // await readLocationForUserId(userId);
  }

  static void backgroundLocationFetch() async {
    var prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("userId");
    if (userId != null) {
      List<String> listOfLocalData =
          await LocationServiceRepository.readLocationForUserId(userId);

      if (listOfLocalData.isNotEmpty) {
        log("Last element: ${listOfLocalData.last}");
        Map<String, dynamic> lastLocationMap =
            json.decode(listOfLocalData.last);

        // Convert necessary fields to double or appropriate types
        lastLocationMap[Keys.ARG_LATITUDE] =
            double.tryParse(lastLocationMap[Keys.ARG_LATITUDE].toString()) ??
                0.0;
        lastLocationMap[Keys.ARG_LONGITUDE] =
            double.tryParse(lastLocationMap[Keys.ARG_LONGITUDE].toString()) ??
                0.0;
        lastLocationMap[Keys.ARG_ACCURACY] =
            double.tryParse(lastLocationMap[Keys.ARG_ACCURACY].toString()) ??
                0.0;
        lastLocationMap[Keys.ARG_ALTITUDE] =
            double.tryParse(lastLocationMap[Keys.ARG_ALTITUDE].toString()) ??
                0.0;
        lastLocationMap[Keys.ARG_SPEED] =
            double.tryParse(lastLocationMap[Keys.ARG_SPEED].toString()) ?? 0.0;
        lastLocationMap[Keys.ARG_SPEED_ACCURACY] = double.tryParse(
                lastLocationMap[Keys.ARG_SPEED_ACCURACY].toString()) ??
            0.0;
        lastLocationMap[Keys.ARG_HEADING] =
            double.tryParse(lastLocationMap[Keys.ARG_HEADING].toString()) ??
                0.0;
        lastLocationMap[Keys.ARG_TIME] =
            double.tryParse(lastLocationMap[Keys.ARG_TIME].toString()) ?? 0.0;

        LocationDto lastLocation = LocationDto.fromJson(lastLocationMap);
        log("lastLocation: $lastLocation");
        Position currentLocation = await Geolocator.getCurrentPosition();
        log("current location: $currentLocation");

        bool isDistMoreThan30m = isDistanceMoreThan30m(
          lastLat: lastLocation.latitude,
          lastLng: lastLocation.latitude,
          currentLat: currentLocation.latitude,
          currentLng: currentLocation.longitude,
        );
        if (isDistMoreThan30m) {
          storeLocationInTextFile(userId: userId);
        }
      } else {
        log("listOfLocalData is empty");
      }
    } else {
      log("userId in sharedpreference is empty or unable to fetch");
    }
  }

  static void storeLocationInTextFile({
    required int userId,
  }) async {
    String fileName = "$userId.txt";
    File file = File(fileName);
    Position currentPosition = await Geolocator.getCurrentPosition();

    // Create a LocationDto instance from the Position object
    LocationDto locationDto = LocationDto.fromJson({
      Keys.ARG_LATITUDE: currentPosition.latitude,
      Keys.ARG_LONGITUDE: currentPosition.longitude,
      Keys.ARG_ACCURACY: currentPosition.accuracy,
      Keys.ARG_ALTITUDE: currentPosition.altitude,
      Keys.ARG_SPEED: currentPosition.speed,
      Keys.ARG_SPEED_ACCURACY: currentPosition.speedAccuracy,
      Keys.ARG_HEADING: currentPosition.heading,
      Keys.ARG_TIME: DateTime.now().millisecondsSinceEpoch.toDouble(),
      Keys.ARG_IS_MOCKED: currentPosition.isMocked,
      Keys.ARG_PROVIDER: "Geolocator" // Optional, provide your source
    });
    // Check if the file exists, if not create it.
    // if (!file.existsSync()) {
    //   await file.create(recursive: true);
    // }
    String locationDtoJson = json.encode(locationDto.toJson());
    if (await file.exists()) {
      await file.writeAsString('$locationDtoJson\n', mode: FileMode.append);
    } else {
      FileManager.writeContentInFile(fileName, locationDtoJson);
    }
    log("File stored");
    List<String> fileData = await readLocationForUserId(userId);
    log("File stored ${fileData.length}");
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
    log("Distance between two location is = $distance");
    return distance > 30;
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inDays);
}
