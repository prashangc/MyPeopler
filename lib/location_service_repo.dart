import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

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
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inDays);
}
