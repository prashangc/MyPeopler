// To parse this JSON data, do
//
//     final clientTypeOptions = clientTypeOptionsFromJson(jsonString);

import 'dart:convert';

List<ClientTypeOptions> clientTypeOptionsFromJson(String str) => List<ClientTypeOptions>.from(json.decode(str).map((x) => ClientTypeOptions.fromJson(x)));

String clientTypeOptionsToJson(List<ClientTypeOptions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientTypeOptions {
    final int? id;
    final String? name;

    ClientTypeOptions({
        this.id,
        this.name,
    });

    factory ClientTypeOptions.fromJson(Map<String, dynamic> json) => ClientTypeOptions(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
