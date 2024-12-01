import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:my_peopler/custom_location_dto.dart';
import 'package:my_peopler/src/helpers/fileManager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WriteInFile {
  static void writeStaticDataInTextFile() async {
    var prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("userId");
    if (userId != null) {
      String fileName = "$userId.txt";

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      String formattedDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      LocationDto locationDto = LocationDto.fromJson({
        'latitude': 1111111.11,
        'longitude': 1111111.11,
        'accuracy': 0.0,
        'altitude': 0.0,
        'speed': 0.0,
        'speed_accuracy': 0.0,
        'heading': 0.0,
        'time': formattedDate,
        'is_mocked': false,
        'provider': '',
      });
      String locationDtoJson = json.encode(locationDto.toJson());
      if (await file.exists()) {
        await file.writeAsString('$locationDtoJson\n', mode: FileMode.append);
      } else {
        FileManager.writeContentInFile(fileName, locationDtoJson);
      }
    }
  }

  static Future<void> storeDataInFile({
    required int? userId,
    required Position position,
  }) async {
    // var prefs = await SharedPreferences.getInstance();
    // int? userId = prefs.getInt("userId");
    if (userId != null) {
      String fileName = "$userId.txt";
      // final directory = await getApplicationDocumentsDirectory();
      // final file = File('${directory.path}/$fileName');
      File file = File(fileName);
      String formattedDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      LocationDto locationDto = LocationDto.fromJson({
        Keys.ARG_LATITUDE: position.latitude,
        Keys.ARG_LONGITUDE: position.longitude,
        Keys.ARG_ACCURACY: position.accuracy,
        Keys.ARG_ALTITUDE: position.altitude,
        Keys.ARG_SPEED: position.speed,
        Keys.ARG_SPEED_ACCURACY: position.speedAccuracy,
        Keys.ARG_HEADING: position.heading,
        Keys.ARG_TIME: formattedDate,
        // Keys.ARG_TIME: DateTime.now().millisecondsSinceEpoch.toDouble(),
        Keys.ARG_IS_MOCKED: position.isMocked,
        Keys.ARG_PROVIDER: "Geolocator" // Optional, provide your source
      });
      String locationDtoJson = json.encode(locationDto.toJson());
      if (await file.exists()) {
        FileManager.writeContentInFile(fileName, json.encode(locationDtoJson));

        // await file.writeAsString('$locationDtoJson\n', mode: FileMode.append);
      } else {
        // read
        FileManager.writeContentInFile(fileName, locationDtoJson);
      }
      log('OUTPUT --> FILE STORED');
    }
  }
}
