
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'dart:convert';

// part 'holidayResponse.freezed.dart';
// part 'holidayResponse.g.dart';

// HolidayResponse holidayResponseFromJson(String str) => HolidayResponse.fromJson(json.decode(str));

// String holidayResponseToJson(HolidayResponse data) => json.encode(data.toJson());

// @freezed
// abstract class HolidayResponse with _$HolidayResponse {
//     const factory HolidayResponse({
//         required List<Holiday> data,
//     }) = _HolidayResponse;

//     factory HolidayResponse.fromJson(Map<String, dynamic> json) => _$HolidayResponseFromJson(json);
// }

// @freezed
// abstract class Holiday with _$Holiday {
//     const factory Holiday({
//         required int? id,
//         required int? created_by,
//         required String? holiday_name,
//         required DateTime? startDate,
//         required DateTime? endDate,
//         required String? description,
//         required int? publication_status,
//         required int? deletion_status,
//         required dynamic deleted_at,
//         required DateTime? created_at,
//         required DateTime? updated_at,
//         required String? name,
//     }) = _Holiday;

//     factory Holiday.fromJson(Map<String, dynamic> json) => _$HolidayFromJson(json);
// }


// // To parse this JSON data, do
// //
// //     final holidayResponse = holidayResponseFromJson(jsonString);

import 'dart:convert';

HolidayResponse holidayResponseFromJson(String str) => HolidayResponse.fromJson(json.decode(str));

String holidayResponseToJson(HolidayResponse data) => json.encode(data.toJson());

class HolidayResponse {
     List<Holiday>? data;

    HolidayResponse({
        this.data,
    });

    factory HolidayResponse.fromJson(Map<String, dynamic> json) => HolidayResponse(
        data: json["data"] == null ? [] : List<Holiday>.from(json["data"]!.map((x) => Holiday.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Holiday {
    final int? id;
    final String? publishedBy;
    final String? holidayName;
    final DateTime? startDate;
    final DateTime? endDate;
    final String? description;
    final DateTime? createdAt;

    Holiday({
        this.id,
        this.publishedBy,
        this.holidayName,
        this.startDate,
        this.endDate,
        this.description,
        this.createdAt,
    });

    factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        id: json["id"],
        publishedBy: json["published_by"],
        holidayName: json["holiday_name"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        description: json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "published_by": publishedBy,
        "holiday_name": holidayName,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "created_at": createdAt?.toIso8601String(),
    };
}
