// To parse this JSON data, do
//
//     final postExpenseResponse = postExpenseResponseFromJson(jsonString);

import 'dart:convert';

PostExpenseResponse postExpenseResponseFromJson(String str) => PostExpenseResponse.fromJson(json.decode(str));

String postExpenseResponseToJson(PostExpenseResponse data) => json.encode(data.toJson());

class PostExpenseResponse {
    Data data;

    PostExpenseResponse({
        required this.data,
    });

    factory PostExpenseResponse.fromJson(Map<String, dynamic> json) => PostExpenseResponse(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    String expenseCategoryId;
    String description;
    DateTime date;
    int createdBy;
    int employeeId;
    String askingAmount;
    DateTime updatedAt;
    DateTime createdAt;
    int id;
    dynamic attachmentUrl;
    ExpenseCategory expenseCategory;

    Data({
        required this.expenseCategoryId,
        required this.description,
        required this.date,
        required this.createdBy,
        required this.employeeId,
        required this.askingAmount,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
        required this.attachmentUrl,
        required this.expenseCategory,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        expenseCategoryId: json["expense_category_id"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        createdBy: json["created_by"],
        employeeId: json["employee_id"],
        askingAmount: json["asking_amount"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        attachmentUrl: json["attachment_url"],
        expenseCategory: ExpenseCategory.fromJson(json["expense_category"]),
    );

    Map<String, dynamic> toJson() => {
        "expense_category_id": expenseCategoryId,
        "description": description,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "created_by": createdBy,
        "employee_id": employeeId,
        "asking_amount": askingAmount,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "attachment_url": attachmentUrl,
        "expense_category": expenseCategory.toJson(),
    };
}

class ExpenseCategory {
    int id;
    String name;
    int createdBy;
    DateTime createdAt;
    DateTime updatedAt;

    ExpenseCategory({
        required this.id,
        required this.name,
        required this.createdBy,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ExpenseCategory.fromJson(Map<String, dynamic> json) => ExpenseCategory(
        id: json["id"],
        name: json["name"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_by": createdBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
