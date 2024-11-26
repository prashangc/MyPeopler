
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'awardResponse.freezed.dart';
part 'awardResponse.g.dart';

AwardResponse awardResponseFromJson(String str) => AwardResponse.fromJson(json.decode(str));

String awardResponseToJson(AwardResponse data) => json.encode(data.toJson());

@freezed
abstract class AwardResponse with _$AwardResponse {
    const factory AwardResponse({
        required List<Award> data,
    }) = _AwardResponse;

    factory AwardResponse.fromJson(Map<String, dynamic> json) => _$AwardResponseFromJson(json);
}

@freezed
abstract class Award with _$Award {
    const factory Award({
        required int? id,
        required int? created_by,
        required int? employee_id,
        required int? award_category_id,
        required String? gift_item,
        required DateTime? select_month,
        required String? description,
        required int? publication_status,
        required int? deletion_status,
        required dynamic deleted_at,
        required DateTime? created_at,
        required DateTime? updated_at,
    }) = _Award;

    factory Award.fromJson(Map<String, dynamic> json) => _$AwardFromJson(json);
}
