// To parse this JSON data, do
//
//     final sfaPaymentListModel = sfaPaymentListModelFromJson(jsonString);

import 'dart:convert';

import 'package:nepali_date_picker/nepali_date_picker.dart';

SfaPaymentListModel sfaPaymentListModelFromJson(String str) => SfaPaymentListModel.fromJson(json.decode(str));

String sfaPaymentListModelToJson(SfaPaymentListModel data) => json.encode(data.toJson());

class SfaPaymentListModel {
    final List<SfaPaymentList>? data;

    SfaPaymentListModel({
        this.data,
    });

    factory SfaPaymentListModel.fromJson(Map<String, dynamic> json) => SfaPaymentListModel(
        data: json["data"] == null ? [] : List<SfaPaymentList>.from(json["data"]!.map((x) => SfaPaymentList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SfaPaymentList {
    final int? id;
    final int? amount;
    final int? employeeId;
    final int? customerId;
    final String? method;
    final String? refNo;
    final String? paymentNote;
    final NepaliDateTime? createdAt;
    final NepaliDateTime? updatedAt;
    final String? customerName;
    final String? employeeName;
    final String? status;

    SfaPaymentList({
        this.id,
        this.amount,
        this.employeeId,
        this.customerId,
        this.method,
        this.refNo,
        this.paymentNote,
        this.createdAt,
        this.updatedAt,
        this.customerName,
        this.employeeName,
        this.status,
    });

    factory SfaPaymentList.fromJson(Map<String, dynamic> json) => SfaPaymentList(
        id: json["id"],
        amount: json["amount"],
        employeeId: json["employee_id"],
        customerId: json["customer_id"],
        method: json["method"],
        refNo: json["ref_no"],
        paymentNote: json["payment_note"],
        createdAt: json["created_at"] == null ? null : NepaliDateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : NepaliDateTime.tryParse(json["updated_at"]),
        customerName: json["customer_name"],
        employeeName: json["employee_name"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "employee_id": employeeId,
        "customer_id": customerId,
        "method": method,
        "ref_no": refNo,
        "payment_note": paymentNote,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "customer_name": customerName,
        "employee_name": employeeName,
        "status": status,
    };
}
