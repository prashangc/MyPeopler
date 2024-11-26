// To parse this JSON data, do
//
//     final remainingLeaveResponse = remainingLeaveResponseFromJson(jsonString);

import 'dart:convert';

RemainingLeaveResponse remainingLeaveResponseFromJson(String str) => RemainingLeaveResponse.fromJson(json.decode(str));

String remainingLeaveResponseToJson(RemainingLeaveResponse data) => json.encode(data.toJson());

class RemainingLeaveResponse {
    final List<RemainingLeave>? data;

    RemainingLeaveResponse({
        this.data,
    });

    factory RemainingLeaveResponse.fromJson(Map<String, dynamic> json) => RemainingLeaveResponse(
        data: json["data"] == null ? [] : List<RemainingLeave>.from(json["data"]!.map((x) => RemainingLeave.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class RemainingLeave {
    final int? id;
    final String? leaveCategory;
    final String? allowedLeaveDays;
    final String? totalLeaveTaken;
    final String? remainingDays;
    RemainingLeave({
        this.id,
        this.leaveCategory,
        this.allowedLeaveDays,
        this.totalLeaveTaken,
        this.remainingDays
    });

    factory RemainingLeave.fromJson(Map<String, dynamic> json) => RemainingLeave(
        id: json["id"],
        leaveCategory: json["leave_category"],
        allowedLeaveDays: json["allowed_leave_days"] ?? '0',
        totalLeaveTaken: json["total_leave_taken"] ?? '0',
        remainingDays: (int.parse(json["allowed_leave_days"]?? '0') - int.parse(json["total_leave_taken"]?? '0')).isNegative ?'0':(int.parse(json["allowed_leave_days"]?? '0') - int.parse(json["total_leave_taken"]?? '0')).toString()
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "leave_category": leaveCategory,
        "allowed_leave_days": allowedLeaveDays,
        "total_leave_taken": totalLeaveTaken,
    };
}
