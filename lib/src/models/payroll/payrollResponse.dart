
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'payrollResponse.freezed.dart';
part 'payrollResponse.g.dart';

PayrollResponse payrollResponseFromJson(String str) => PayrollResponse.fromJson(json.decode(str));

String payrollResponseToJson(PayrollResponse data) => json.encode(data.toJson());

@freezed
abstract class PayrollResponse with _$PayrollResponse {
    const factory PayrollResponse({
        required PayrollData? data,
    }) = _PayrollResponse;

    factory PayrollResponse.fromJson(Map<String, dynamic> json) => _$PayrollResponseFromJson(json);
}

@freezed
abstract class PayrollData with _$PayrollData {
    const factory PayrollData({
        required Payroll? payroll,
        required Bonus? bonus,
        required Grade? grade,
    }) = _PayrollData;

    factory PayrollData.fromJson(Map<String, dynamic> json) => _$PayrollDataFromJson(json);
}

@freezed
abstract class Bonus with _$Bonus {
    const factory Bonus({
        required int? id,
        required int? created_by,
        required int? user_id,
        required String? bonus_name,
        required DateTime? bonus_month,
        required String? bonus_amount,
        required String? bonus_description,
        required int? deletion_status,
        required dynamic deleted_at,
        required DateTime? created_at,
        required DateTime? updated_at,
    }) = _Bonus;

    factory Bonus.fromJson(Map<String, dynamic> json) => _$BonusFromJson(json);
}

@freezed
abstract class Grade with _$Grade {
    const factory Grade({
        required int? id,
        required int? user_id,
        required int? grade_id,
        required String? grade,
        required DateTime? date,
        required DateTime? created_at,
        required DateTime? updated_at,
        required int? amount,
    }) = _Grade;

    factory Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);
}

@freezed
abstract class Payroll with _$Payroll {
    const factory Payroll({
        required int? id,
        required int? created_by,
        required int? user_id,
        required int? employee_type,
        required String? basic_salary,
        required String? house_rent_allowance,
        required String? medical_allowance,
        required dynamic special_allowance,
        required dynamic provident_fund_contribution,
        required dynamic other_allowance,
        required dynamic tax_deduction,
        required dynamic provident_fund_deduction,
        required dynamic other_deduction,
        required int? activation_status,
        required dynamic date,
        required DateTime? created_at,
        required DateTime? updated_at,
    }) = _Payroll;

    factory Payroll.fromJson(Map<String, dynamic> json) => _$PayrollFromJson(json);
}
