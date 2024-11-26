
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage =  FlutterSecureStorage();

Future<String> readValue(String key) async {
     String? value = await storage.read(key: key);
     return value ?? '';
}

Future<void> writeValue(String key, String? value) async {
     await storage.write(key: key, value: value);
}

const graceTime = 'GRACE_TIME';
const graceEnd = 'GRACE_END_TIME';
const lunchOutTime = 'LUNCH_OUT_TIME';
const lunchInTime = 'LUNCH_IN_TIME';