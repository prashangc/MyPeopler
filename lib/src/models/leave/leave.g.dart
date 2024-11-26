// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveImpl _$$LeaveImplFromJson(Map<String, dynamic> json) => _$LeaveImpl(
      id: (json['id'] as num?)?.toInt(),
      created_by: (json['created_by'] as num?)?.toInt(),
      leave_category_id: (json['leave_category_id'] as num?)?.toInt(),
      last_leave_category_id: json['last_leave_category_id'] as String?,
      last_leave_period: json['last_leave_period'] as String?,
      start_date: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      end_date: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      leave_address: json['leave_address'] as String?,
      last_leave_date: json['last_leave_date'] == null
          ? null
          : DateTime.parse(json['last_leave_date'] as String),
      reason: json['reason'] as String?,
      during_leave: json['during_leave'] as String?,
      publication_status: (json['publication_status'] as num?)?.toInt(),
      deletion_status: (json['deletion_status'] as num?)?.toInt(),
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$LeaveImplToJson(_$LeaveImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_by': instance.created_by,
      'leave_category_id': instance.leave_category_id,
      'last_leave_category_id': instance.last_leave_category_id,
      'last_leave_period': instance.last_leave_period,
      'start_date': instance.start_date?.toIso8601String(),
      'end_date': instance.end_date?.toIso8601String(),
      'leave_address': instance.leave_address,
      'last_leave_date': instance.last_leave_date?.toIso8601String(),
      'reason': instance.reason,
      'during_leave': instance.during_leave,
      'publication_status': instance.publication_status,
      'deletion_status': instance.deletion_status,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
