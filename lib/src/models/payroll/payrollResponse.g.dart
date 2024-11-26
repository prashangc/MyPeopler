// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payrollResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayrollResponseImpl _$$PayrollResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PayrollResponseImpl(
      data: json['data'] == null
          ? null
          : PayrollData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PayrollResponseImplToJson(
        _$PayrollResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$PayrollDataImpl _$$PayrollDataImplFromJson(Map<String, dynamic> json) =>
    _$PayrollDataImpl(
      payroll: json['payroll'] == null
          ? null
          : Payroll.fromJson(json['payroll'] as Map<String, dynamic>),
      bonus: json['bonus'] == null
          ? null
          : Bonus.fromJson(json['bonus'] as Map<String, dynamic>),
      grade: json['grade'] == null
          ? null
          : Grade.fromJson(json['grade'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PayrollDataImplToJson(_$PayrollDataImpl instance) =>
    <String, dynamic>{
      'payroll': instance.payroll,
      'bonus': instance.bonus,
      'grade': instance.grade,
    };

_$BonusImpl _$$BonusImplFromJson(Map<String, dynamic> json) => _$BonusImpl(
      id: (json['id'] as num?)?.toInt(),
      created_by: (json['created_by'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      bonus_name: json['bonus_name'] as String?,
      bonus_month: json['bonus_month'] == null
          ? null
          : DateTime.parse(json['bonus_month'] as String),
      bonus_amount: json['bonus_amount'] as String?,
      bonus_description: json['bonus_description'] as String?,
      deletion_status: (json['deletion_status'] as num?)?.toInt(),
      deleted_at: json['deleted_at'],
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$BonusImplToJson(_$BonusImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.created_by,
      'user_id': instance.user_id,
      'bonus_name': instance.bonus_name,
      'bonus_month': instance.bonus_month?.toIso8601String(),
      'bonus_amount': instance.bonus_amount,
      'bonus_description': instance.bonus_description,
      'deletion_status': instance.deletion_status,
      'deleted_at': instance.deleted_at,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };

_$GradeImpl _$$GradeImplFromJson(Map<String, dynamic> json) => _$GradeImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      grade_id: (json['grade_id'] as num?)?.toInt(),
      grade: json['grade'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      amount: (json['amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$GradeImplToJson(_$GradeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'grade_id': instance.grade_id,
      'grade': instance.grade,
      'date': instance.date?.toIso8601String(),
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'amount': instance.amount,
    };

_$PayrollImpl _$$PayrollImplFromJson(Map<String, dynamic> json) =>
    _$PayrollImpl(
      id: (json['id'] as num?)?.toInt(),
      created_by: (json['created_by'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      employee_type: (json['employee_type'] as num?)?.toInt(),
      basic_salary: json['basic_salary'] as String?,
      house_rent_allowance: json['house_rent_allowance'] as String?,
      medical_allowance: json['medical_allowance'] as String?,
      special_allowance: json['special_allowance'],
      provident_fund_contribution: json['provident_fund_contribution'],
      other_allowance: json['other_allowance'],
      tax_deduction: json['tax_deduction'],
      provident_fund_deduction: json['provident_fund_deduction'],
      other_deduction: json['other_deduction'],
      activation_status: (json['activation_status'] as num?)?.toInt(),
      date: json['date'],
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$PayrollImplToJson(_$PayrollImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.created_by,
      'user_id': instance.user_id,
      'employee_type': instance.employee_type,
      'basic_salary': instance.basic_salary,
      'house_rent_allowance': instance.house_rent_allowance,
      'medical_allowance': instance.medical_allowance,
      'special_allowance': instance.special_allowance,
      'provident_fund_contribution': instance.provident_fund_contribution,
      'other_allowance': instance.other_allowance,
      'tax_deduction': instance.tax_deduction,
      'provident_fund_deduction': instance.provident_fund_deduction,
      'other_deduction': instance.other_deduction,
      'activation_status': instance.activation_status,
      'date': instance.date,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
