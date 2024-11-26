// To parse this JSON data, do
//
//     final expensesCategoriesModel = expensesCategoriesModelFromJson(jsonString);

import 'dart:convert';

ExpensesCategoriesModel expensesCategoriesModelFromJson(String str) => ExpensesCategoriesModel.fromJson(json.decode(str));

String expensesCategoriesModelToJson(ExpensesCategoriesModel data) => json.encode(data.toJson());

class ExpensesCategoriesModel {
    final List<ExpensesCategories>? data;

    ExpensesCategoriesModel({
        this.data,
    });

    factory ExpensesCategoriesModel.fromJson(Map<String, dynamic> json) => ExpensesCategoriesModel(
        data: json["data"] == null ? [] : List<ExpensesCategories>.from(json["data"]!.map((x) => ExpensesCategories.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ExpensesCategories {
    final int? id;
    final String? name;
    final int? createdBy;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    ExpensesCategories({
        this.id,
        this.name,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
    });

    factory ExpensesCategories.fromJson(Map<String, dynamic> json) => ExpensesCategories(
        id: json["id"],
        name: json["name"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
