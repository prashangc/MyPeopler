// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'awardResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AwardResponseImpl _$$AwardResponseImplFromJson(Map<String, dynamic> json) =>
    _$AwardResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => Award.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AwardResponseImplToJson(_$AwardResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$AwardImpl _$$AwardImplFromJson(Map<String, dynamic> json) => _$AwardImpl(
      id: (json['id'] as num?)?.toInt(),
      created_by: (json['created_by'] as num?)?.toInt(),
      employee_id: (json['employee_id'] as num?)?.toInt(),
      award_category_id: (json['award_category_id'] as num?)?.toInt(),
      gift_item: json['gift_item'] as String?,
      select_month: json['select_month'] == null
          ? null
          : DateTime.parse(json['select_month'] as String),
      description: json['description'] as String?,
      publication_status: (json['publication_status'] as num?)?.toInt(),
      deletion_status: (json['deletion_status'] as num?)?.toInt(),
      deleted_at: json['deleted_at'],
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$AwardImplToJson(_$AwardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.created_by,
      'employee_id': instance.employee_id,
      'award_category_id': instance.award_category_id,
      'gift_item': instance.gift_item,
      'select_month': instance.select_month?.toIso8601String(),
      'description': instance.description,
      'publication_status': instance.publication_status,
      'deletion_status': instance.deletion_status,
      'deleted_at': instance.deleted_at,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
