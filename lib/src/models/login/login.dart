
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'package:my_peopler/src/models/user/user.dart';

part 'login.freezed.dart';
part 'login.g.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

@freezed
abstract class Login with _$Login {
    const factory Login({
        required String? token,
        required User? user,
    }) = _Login;

    factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}
