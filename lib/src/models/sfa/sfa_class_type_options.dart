// To parse this JSON data, do
//
//     final classTypeOptions = classTypeOptionsFromJson(jsonString);

import 'dart:convert';

List<ClassTypeOptions> classTypeOptionsFromJson(String str) => List<ClassTypeOptions>.from(json.decode(str).map((x) => ClassTypeOptions.fromJson(x)));

String classTypeOptionsToJson(List<ClassTypeOptions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassTypeOptions {
    final int? id;
    final String? name;

    ClassTypeOptions({
        this.id,
        this.name,
    });

    factory ClassTypeOptions.fromJson(Map<String, dynamic> json) => ClassTypeOptions(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
