// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaveCategoryResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveCategoryResponseImpl _$$LeaveCategoryResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaveCategoryResponseImpl(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LeaveCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LeaveCategoryResponseImplToJson(
        _$LeaveCategoryResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$LeaveCategoryImpl _$$LeaveCategoryImplFromJson(Map<String, dynamic> json) =>
    _$LeaveCategoryImpl(
      id: (json['id'] as num?)?.toInt(),
      leave_category: json['leave_category'] as String?,
      leave_category_description: json['leave_category_description'] as String?,
    );

Map<String, dynamic> _$$LeaveCategoryImplToJson(_$LeaveCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leave_category': instance.leave_category,
      'leave_category_description': instance.leave_category_description,
    };
