// To parse this JSON data, do
//
//     final sfaPaymentScheduleModel = sfaPaymentScheduleModelFromJson(jsonString);

import 'dart:convert';

SfaPaymentScheduleModel sfaPaymentScheduleModelFromJson(String str) => SfaPaymentScheduleModel.fromJson(json.decode(str));

String sfaPaymentScheduleModelToJson(SfaPaymentScheduleModel data) => json.encode(data.toJson());

class SfaPaymentScheduleModel {
    List<Datum> data;

    SfaPaymentScheduleModel({
        required this.data,
    });

    factory SfaPaymentScheduleModel.fromJson(Map<String, dynamic> json) => SfaPaymentScheduleModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String title;
    int employeeId;
    int createdBy;
    // NepaliDateTime? createdAt;
    // NepaliDateTime? updatedAt;
    String fromDate;
    String toDate;
    String employeeName;
    List<Item> items;

    Datum({
        required this.id,
        required this.title,
        required this.employeeId,
        required this.createdBy,
        // required this.createdAt,
        // required this.updatedAt,
        required this.fromDate,
        required this.toDate,
        required this.employeeName,
        required this.items,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        employeeId: json["employee_id"],
        createdBy: json["created_by"],
        // createdAt: json["created_at"] == null ? null : NepaliDateTime.tryParse(json["created_at"]),
        // updatedAt: json["updated_at"] == null ? null :NepaliDateTime.tryParse(json["updated_at"]),
        fromDate: json["from_date"],
        toDate: json["to_date"],
        employeeName: json["employee_name"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "employee_id": employeeId,
        "created_by": createdBy,
        // "created_at": createdAt?.toIso8601String(),
        // "updated_at": updatedAt?.toIso8601String(),
        "from_date": fromDate,
        "to_date": toDate,
        "employee_name": employeeName,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    int id;
    int customerId;
    int paymentScheduleId;
    int? planningAmount;
    int dueDay;
    int dueAmount;
    dynamic achievement;
    String customerName;
    List<Plan> plans;

    Item({
        required this.id,
        required this.customerId,
        required this.paymentScheduleId,
        required this.planningAmount,
        required this.dueDay,
        required this.dueAmount,
        required this.achievement,
        required this.customerName,
        required this.plans,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        customerId: json["customer_id"],
        paymentScheduleId: json["payment_schedule_id"],
        planningAmount: json["planning_amount"],
        dueDay: json["due_day"],
        dueAmount: json["due_amount"],
        achievement: json["achievement"],
        customerName: json["customer_name"],
        plans: List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "payment_schedule_id": paymentScheduleId,
        "planning_amount": planningAmount,
        "due_day": dueDay,
        "due_amount": dueAmount,
        "achievement": achievement,
        "customer_name": customerName,
        "plans": List<dynamic>.from(plans.map((x) => x.toJson())),
    };
}

class Plan {
    int id;
    int paymentScheduleItemId;
    String planningDate;
    int? planningAmount;
    dynamic achievement;
    // NepaliDateTime? createdAt;
    // NepaliDateTime? updatedAt;

    Plan({
        required this.id,
        required this.paymentScheduleItemId,
        required this.planningDate,
        required this.planningAmount,
        required this.achievement,
        // required this.createdAt,
        // required this.updatedAt,
    });

    factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        paymentScheduleItemId: json["payment_schedule_item_id"],
        planningDate: json["planning_date"],
        planningAmount: json["planning_amount"],
        achievement: json["achievement"],
        // createdAt: json["created_at"] == null ? null : NepaliDateTime.parse(json["created_at"]),
        // updatedAt: json["updated_at"] == null ? null : NepaliDateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "payment_schedule_item_id": paymentScheduleItemId,
        "planning_date": planningDate,
        "planning_amount": planningAmount,
        "achievement": achievement,
        // "created_at": createdAt?.toIso8601String(),
        // "updated_at": updatedAt?.toIso8601String(),
    };
}
