
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'leave.freezed.dart';
part 'leave.g.dart';

List<Leave> leaveFromJson(String str) => List<Leave>.from(json.decode(str).map((x) => Leave.fromJson(x)));

String leaveToJson(List<Leave> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


@freezed
abstract class Leave with _$Leave {
    const factory Leave({
        required int? id,
        required int? created_by,
        required int? leave_category_id,
        required String? last_leave_category_id,
        required String? last_leave_period,
        required DateTime? start_date,
        required DateTime? end_date,
        required String? leave_address,
        required DateTime? last_leave_date,
        required String? reason,
        required String? during_leave,
        required int? publication_status,
        required int? deletion_status,
        required DateTime? created_at,
        required DateTime? updated_at,
    }) = _Leave;

    factory Leave.fromJson(Map<String, dynamic> json) => _$LeaveFromJson(json);
}
