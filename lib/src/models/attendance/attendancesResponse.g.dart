// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendancesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendancesResponseImpl _$$AttendancesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendancesResponseImpl(
      attendances: json['data'] == null? [] : (json['data'] as List<dynamic>)   // change 'attendances' to 'data'
          .map((e) => Attendance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AttendancesResponseImplToJson(
        _$AttendancesResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.attendances,
    };

_$AttendanceImpl _$$AttendanceImplFromJson(Map<String, dynamic> json) =>
    _$AttendanceImpl(
      id: (json['id'] as num?)?.toInt(),
      attendance_date: json['attendance_date'] == null
          ? null
          : NepaliDateTime.tryParse(json['attendance_date']),
      shift_name: json['shift_name'] as String?,
      details: (json['details'] as List<dynamic>)
          .map((e) => AttendanceDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AttendanceImplToJson(_$AttendanceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attendance_date': "${instance.attendance_date?.year.toString().padLeft(4, '0')}-${instance.attendance_date?.month.toString().padLeft(2, '0')}-${instance.attendance_date?.day.toString().padLeft(2, '0')}",
      'shift_name': instance.shift_name,
      'details': instance.details,
    };

_$AttendanceDetailImpl _$$AttendanceDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceDetailImpl(
      id: (json['id'] as num?)?.toInt(),
      attendance_id: (json['attendance_id'] as num?)?.toInt(),
      attendance_date: json['attendance_date'] == null
          ? null
          : NepaliDateTime.tryParse(json['attendance_date'] as String),
      state: (json['state'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AttendanceDetailImplToJson(
        _$AttendanceDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attendance_id': instance.attendance_id,
      'attendance_date': instance.attendance_date?.toIso8601String(),
      'state': instance.state,
    };
