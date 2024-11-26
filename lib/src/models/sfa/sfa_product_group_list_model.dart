// To parse this JSON data, do
//
//     final sfaProductGroupListModel = sfaProductGroupListModelFromJson(jsonString);

import 'dart:convert';

SfaProductGroupListModel sfaProductGroupListModelFromJson(String str) => SfaProductGroupListModel.fromJson(json.decode(str));

String sfaProductGroupListModelToJson(SfaProductGroupListModel data) => json.encode(data.toJson());

class SfaProductGroupListModel {
     List<SfaProductGroupList>? data;

    SfaProductGroupListModel({
        this.data,
    });

    factory SfaProductGroupListModel.fromJson(Map<String, dynamic> json) => SfaProductGroupListModel(
        data: json["data"] == null ? [] : List<SfaProductGroupList>.from(json["data"]!.map((x) => SfaProductGroupList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SfaProductGroupList {
    final int? id;
    final String? name;

    SfaProductGroupList({
        this.id,
        this.name,
    });

    factory SfaProductGroupList.fromJson(Map<String, dynamic> json) => SfaProductGroupList(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
