// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      role: json['role'] as String?,
      father_name: json['father_name'],
      mother_name: json['mother_name'],
      spouse_name: json['spouse_name'],
      email: json['email'] as String?,
      present_address: json['present_address'],
      permanent_address: json['permanent_address'],
      contact_no_one: json['contact_no_one'] as String?,
      phone: json['phone'] as String?,
      contact_no_two: json['contact_no_two'],
      date_of_birth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      avatar: json['avatar'] as String?,
      department_id: json['department_id'],
      designation_id: json['designation_id'],
      joining_date: json['joining_date'],
      department_name: json['department_name'],
      designation_name: json['designation_name'] as String?,
      enable_attendance_from_mobile: json['enable_attendance_from_mobile'],
      enable_live_tracking: json['enable_live_tracking'],
      attendance_boundary: (json['attendance_boundary'] as List<dynamic>?)
          ?.map((e) => AttendanceBoundary.fromJson(e as Map<String, dynamic>))
          .toList(),
      shifts: (json['shifts'] as List<dynamic>?)
          ?.map((e) => Shift.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'gender': instance.gender,
      'role': instance.role,
      'father_name': instance.father_name,
      'mother_name': instance.mother_name,
      'spouse_name': instance.spouse_name,
      'email': instance.email,
      'present_address': instance.present_address,
      'permanent_address': instance.permanent_address,
      'contact_no_one': instance.contact_no_one,
      'phone': instance.phone,
      'contact_no_two': instance.contact_no_two,
      'date_of_birth': instance.date_of_birth?.toIso8601String(),
      'avatar': instance.avatar,
      'department_id': instance.department_id,
      'designation_id': instance.designation_id,
      'joining_date': instance.joining_date,
      'department_name': instance.department_name,
      'designation_name': instance.designation_name,
      'enable_attendance_from_mobile': instance.enable_attendance_from_mobile,
      'enable_live_tracking': instance.enable_live_tracking,
      'attendance_boundary': instance.attendance_boundary,
      'shifts': instance.shifts,
    };
