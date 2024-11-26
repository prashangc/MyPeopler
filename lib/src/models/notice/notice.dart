
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'notice.freezed.dart';
part 'notice.g.dart';

List<Notice> noticeFromJson(String str) => List<Notice>.from(json.decode(str).map((x) => Notice.fromJson(x)));

String noticeToJson(List<Notice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@freezed
abstract class Notice with _$Notice {
    const factory Notice({
        required int? id,
        required String? published_by,
        required String? title,
        required String? description,
        required DateTime? start_date,
        required DateTime? end_date,
        required DateTime? created_at,
    }) = _Notice;

    factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
}
