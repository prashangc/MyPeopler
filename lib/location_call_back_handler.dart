import 'dart:async';
import 'package:background_locator_2/location_dto.dart';
import 'package:my_peopler/location_service_repo.dart';

@pragma('vm:entry-point')
class LocationCallbackHandler {

  @pragma('vm:entry-point')
  static Future<void> initCallback(Map<String, dynamic> params) async {
     await LocationServiceRepository().initCallback(params);
  }

  @pragma('vm:entry-point')
  static Future<void> disposeCallback() async {
    await LocationServiceRepository().dispose();
  }

  @pragma('vm:entry-point')
  static Future<void> callback(LocationDto locationDto) async {
    await LocationServiceRepository().callback(locationDto);
  }

  @pragma('vm:entry-point')
  static Future<void> notificationCallback() async {}
}
