
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'package:my_peopler/src/models/models.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

@freezed
abstract class Profile with _$Profile {
    const factory Profile({
        required User data,
    }) = _Profile;

    factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}


