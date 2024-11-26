// // To parse this JSON data, do
// //
// //     final getExpensesModel = getExpensesModelFromJson(jsonString);

// import 'dart:convert';

// import 'package:nepali_date_picker/nepali_date_picker.dart';



// GetExpensesModel getExpensesModelFromJson(String str) => GetExpensesModel.fromJson(json.decode(str));

// String getExpensesModelToJson(GetExpensesModel data) => json.encode(data.toJson());

// class GetExpensesModel {
//    final Map<String, List<Expense>> data;

//     GetExpensesModel({
//         required this.data,
//     });

//     factory GetExpensesModel.fromJson(Map<String, dynamic> json) => GetExpensesModel(
//         data: Map.from(json["data"]).map((k, v) => MapEntry<String, List<Expense>>(k, List<Expense>.from(v.map((x) => Expense.fromJson(x))))),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": Map.from(data).map((k, v) => MapEntry<String, List<Expense>>(k,List<Expense>.from(v.map((x) => x.toJson())))),
//     };
// }

// class Expense {
//    final int id;
//    final int createdBy;
//    final int employeeId;
//    final int expenseCategoryId;
//    final String askingAmount;
//    final String description;
//    final String? date;
//    final String? attachment;
//    final String? status;
//    final String? approvedBy;
//    final dynamic approvedAt;
//    final String? statusNote;
//    final NepaliDateTime? createdAt;
//    final NepaliDateTime? updatedAt;
//    final dynamic settleNote;
//    final dynamic settleBy;
//    final dynamic settleAt;
//    final dynamic approvedAmount;
//    final String? employeeName;
//    final String? category;
//    final String? attachmentUrl;

//     Expense({
//         required this.id,
//         required this.createdBy,
//         required this.employeeId,
//         required this.expenseCategoryId,
//         required this.askingAmount,
//         required this.description,
//         required this.date,
//         required this.attachment,
//         required this.status,
//         required this.approvedBy,
//         required this.approvedAt,
//         required this.statusNote,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.settleNote,
//         required this.settleBy,
//         required this.settleAt,
//         required this.approvedAmount,
//         required this.employeeName,
//         required this.category,
//         required this.attachmentUrl,
//     });

//     factory Expense.fromJson(Map<String, dynamic> json) => Expense(
//         id: json["id"],
//         createdBy: json["created_by"],
//         employeeId: json["employee_id"],
//         expenseCategoryId: json["expense_category_id"],
//         askingAmount: json["asking_amount"],
//         description: json["description"],
//         date: json["date"],
//         attachment: json["attachment"],
//         status: json["status"],
//         approvedBy: json["approved_by"],
//         approvedAt: json["approved_at"],
//         statusNote: json["status_note"],
//         createdAt: json["created_at"] == null ? null : NepaliDateTime.parse(json["created_at"]),
//         updatedAt: json["created_at"] == null ? null : NepaliDateTime.parse(json["updated_at"]),
//         settleNote: json["settle_note"],
//         settleBy: json["settle_by"],
//         settleAt: json["settle_at"],
//         approvedAmount: json["approved_amount"],
//         employeeName: json["employee_name"],
//         category: json["category_name"],
//         attachmentUrl: json["attachment_url"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "created_by": createdBy,
//         "employee_id": employeeId,
//         "expense_category_id": expenseCategoryId,
//         "asking_amount": askingAmount,
//         "description": description,
//         "date": date,
//         "attachment": attachment,
//         "status": status,
//         "approved_by": approvedBy,
//         "approved_at": approvedAt,
//         "status_note": statusNote,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "settle_note": settleNote,
//         "settle_by": settleBy,
//         "settle_at": settleAt,
//         "approved_amount": approvedAmount,
//         "employee_name": employeeName,
//         "category_name": category,
//         "attachment_url": attachmentUrl,
//     };
// }
