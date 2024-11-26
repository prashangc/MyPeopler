// To parse this JSON data, do
//
//     final beatOptionsModel = beatOptionsModelFromJson(jsonString);

import 'dart:convert';

List<BeatOptionsModel> beatOptionsModelFromJson(String str) => List<BeatOptionsModel>.from(json.decode(str).map((x) => BeatOptionsModel.fromJson(x)));

String beatOptionsModelToJson(List<BeatOptionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BeatOptionsModel {
    final int? id;
    final String? name;

    BeatOptionsModel({
        this.id,
        this.name,
    });

    factory BeatOptionsModel.fromJson(Map<String, dynamic> json) => BeatOptionsModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
