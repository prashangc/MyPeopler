// To parse this JSON data, do
//

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'leaveCategoryResponse.freezed.dart';
part 'leaveCategoryResponse.g.dart';

LeaveCategoryResponse leaveCategoryResponseFromJson(String str) => LeaveCategoryResponse.fromJson(json.decode(str));

String leaveCategoryResponseToJson(LeaveCategoryResponse data) => json.encode(data.toJson());

@freezed
abstract class LeaveCategoryResponse with _$LeaveCategoryResponse {
    const factory LeaveCategoryResponse({
        required List<LeaveCategory>? data,
    }) = _LeaveCategoryResponse;

    factory LeaveCategoryResponse.fromJson(Map<String, dynamic> json) => _$LeaveCategoryResponseFromJson(json);
}

@freezed
abstract class LeaveCategory with _$LeaveCategory {
    const factory LeaveCategory({
        required int? id,
        required String? leave_category,
        required String? leave_category_description,
    }) = _LeaveCategory;

    factory LeaveCategory.fromJson(Map<String, dynamic> json) => _$LeaveCategoryFromJson(json);
}
