// To parse this JSON data, do
//
//     final subordinatesModel = subordinatesModelFromJson(jsonString);

import 'dart:convert';

SubordinatesModel subordinatesModelFromJson(String str) => SubordinatesModel.fromJson(json.decode(str));

String subordinatesModelToJson(SubordinatesModel data) => json.encode(data.toJson());

class SubordinatesModel {
    final List<Subordinates>? data;

    SubordinatesModel({
        this.data,
    });

    factory SubordinatesModel.fromJson(Map<String, dynamic> json) => SubordinatesModel(
        data: json["data"] == null ? [] : List<Subordinates>.from(json["data"]!.map((x) => Subordinates.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Subordinates {
    final int? id;
    final String? name;

    Subordinates({
        this.id,
        this.name,
    });

    factory Subordinates.fromJson(Map<String, dynamic> json) => Subordinates(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
