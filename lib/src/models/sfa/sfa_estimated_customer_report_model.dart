// To parse this JSON data, do
//
//     final estimatedCustomerReportModel = estimatedCustomerReportModelFromJson(jsonString);

import 'dart:convert';

EstimatedCustomerReportModel estimatedCustomerReportModelFromJson(String str) => EstimatedCustomerReportModel.fromJson(json.decode(str));

String estimatedCustomerReportModelToJson(EstimatedCustomerReportModel data) => json.encode(data.toJson());

class EstimatedCustomerReportModel {
    List<Datum> data;

    EstimatedCustomerReportModel({
        required this.data,
    });

    factory EstimatedCustomerReportModel.fromJson(Map<String, dynamic> json) => EstimatedCustomerReportModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String name;
    dynamic orderId;
    dynamic orderAmount;
    String customerStatus;

    Datum({
        required this.id,
        required this.name,
        required this.orderId,
        required this.orderAmount,
        required this.customerStatus,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        orderId: json["order_id"],
        orderAmount: json["order_amount"],
        customerStatus: json["customer_status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "order_id": orderId,
        "order_amount": orderAmount,
        "customer_status": customerStatus,
    };
}

