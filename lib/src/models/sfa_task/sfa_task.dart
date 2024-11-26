// To parse this JSON data, do
//
//     final sfaTaskResponse = sfaTaskResponseFromJson(jsonString);

import 'dart:convert';

List<SfaTaskResponse> sfaTaskResponseFromJson(String str) => List<SfaTaskResponse>.from(json.decode(str).map((x) => SfaTaskResponse.fromJson(x)));

String sfaTaskResponseToJson(List<SfaTaskResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SfaTaskResponse {
    final int? id;
    final DateTime? fromDate;
    final DateTime? toDate;
    final String? status;
    final List<Item>? items;

    SfaTaskResponse({
        this.id,
        this.fromDate,
        this.toDate,
        this.status,
        this.items,
    });

    factory SfaTaskResponse.fromJson(Map<String, dynamic> json) => SfaTaskResponse(
        id: json["id"],
        fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
        toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        status: json["status"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "from_date": "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date": "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    final int? id;
    final int? employeeTaskId;
    final String? title;
    final String? description;
    final int? isCompleted;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic taskId;

    Item({
        this.id,
        this.employeeTaskId,
        this.title,
        this.description,
        this.isCompleted,
        this.createdAt,
        this.updatedAt,
        this.taskId,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        employeeTaskId: json["employee_task_id"],
        title: json["title"],
        description: json["description"],
        isCompleted: json["is_completed"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        taskId: json["task_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_task_id": employeeTaskId,
        "title": title,
        "description": description,
        "is_completed": isCompleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "task_id": taskId,
    };
}
