
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'package:nepali_date_picker/nepali_date_picker.dart';

part 'attendancesResponse.freezed.dart';
part 'attendancesResponse.g.dart';

AttendancesResponse attendancesResponseFromJson(String str) => AttendancesResponse.fromJson(json.decode(str));

String attendancesResponseToJson(AttendancesResponse data) => json.encode(data.toJson());

@freezed
abstract class AttendancesResponse with _$AttendancesResponse {
    const factory AttendancesResponse({
        required List<Attendance> attendances,
    }) = _AttendancesResponse;

    factory AttendancesResponse.fromJson(Map<String, dynamic> json) => _$AttendancesResponseFromJson(json);
}

@freezed
abstract class Attendance with _$Attendance {
    const factory Attendance({
        required int? id,
        // required dynamic created_by,
        // required int? user_id,
        required NepaliDateTime? attendance_date,
        // required int? attendance_status,
        // required int? employee_shift_id,
        // required DateTime? created_at,
        // required DateTime? updated_at,
        required String? shift_name,
        required List<AttendanceDetail> details,
    }) = _Attendance;

    factory Attendance.fromJson(Map<String, dynamic> json) => _$AttendanceFromJson(json);
}

@freezed
abstract class AttendanceDetail with _$AttendanceDetail {
    const factory AttendanceDetail({
        required int? id,
        required int? attendance_id,
        required NepaliDateTime? attendance_date,
        // required dynamic device_id,
        required int? state,
        // required DateTime? created_at,
        // required DateTime? updated_at,
    }) = _AttendanceDetail;

    factory AttendanceDetail.fromJson(Map<String, dynamic> json) => _$AttendanceDetailFromJson(json);
}
