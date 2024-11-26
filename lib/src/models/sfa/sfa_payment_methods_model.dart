// To parse this JSON data, do
//
//     final sfaPaymentMethodsModel = sfaPaymentMethodsModelFromJson(jsonString);

import 'dart:convert';

SfaPaymentMethodsModel sfaPaymentMethodsModelFromJson(String str) => SfaPaymentMethodsModel.fromJson(json.decode(str));

String sfaPaymentMethodsModelToJson(SfaPaymentMethodsModel data) => json.encode(data.toJson());

class SfaPaymentMethodsModel {
    final List<SfaPaymentMethods>? data;

    SfaPaymentMethodsModel({
        this.data,
    });

    factory SfaPaymentMethodsModel.fromJson(Map<String, dynamic> json) => SfaPaymentMethodsModel(
        data: json["data"] == null ? [] : List<SfaPaymentMethods>.from(json["data"]!.map((x) => SfaPaymentMethods.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SfaPaymentMethods {
    final String? id;
    final String? name;

    SfaPaymentMethods({
        this.id,
        this.name,
    });

    factory SfaPaymentMethods.fromJson(Map<String, dynamic> json) => SfaPaymentMethods(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
