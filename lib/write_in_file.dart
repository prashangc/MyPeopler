import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:my_peopler/custom_location_dto.dart';
import 'package:my_peopler/location_service_repo.dart';
import 'package:my_peopler/src/helpers/fileManager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WriteInFile {
  // static void createFileAndAddFirstData() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   int? userId = prefs.getInt("userId");
  //   if (userId != null) {
  //     String fileName = "$userId.txt";
  //     final directory = await getApplicationDocumentsDirectory();
  //     final file = File('${directory.path}/$fileName');
  //     if (!(await file.exists())) {
  //       await file.create();
  //       WriteInFile.storeDataInFile();
  //       log("File just created.");
  //     }
  //   }
  // }

  static Future<void> storeDataInFile() async {
    var prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt("userId");
    if (userId != null) {
      String fileName = "$userId.txt";
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      Position position = await Geolocator.getCurrentPosition();
      LocationDto locationDto = LocationDto.fromJson({
        Keys.ARG_LATITUDE: position.latitude,
        Keys.ARG_LONGITUDE: position.longitude,
        Keys.ARG_ACCURACY: position.accuracy,
        Keys.ARG_ALTITUDE: position.altitude,
        Keys.ARG_SPEED: position.speed,
        Keys.ARG_SPEED_ACCURACY: position.speedAccuracy,
        Keys.ARG_HEADING: position.heading,
        Keys.ARG_TIME: DateTime.now().millisecondsSinceEpoch.toDouble(),
        Keys.ARG_IS_MOCKED: position.isMocked,
        Keys.ARG_PROVIDER: "Geolocator" // Optional, provide your source
      });
      String locationDtoJson = json.encode(locationDto.toJson());
      if (await file.exists()) {
        await file.writeAsString('$locationDtoJson\n', mode: FileMode.append);
      } else {
        FileManager.writeContentInFile(fileName, locationDtoJson);
      }
      log("---------------------------------------------------");
      log("---------------------------------------------------");
      log("---------------------------------------------------");
      log("---------------------------------------------------");
      log("output -> File stored");
      List<String> fileData =
          await LocationServiceRepository.readLocationForUserId(userId);
      log("File stored ${fileData.length}");
    }
  }
}
