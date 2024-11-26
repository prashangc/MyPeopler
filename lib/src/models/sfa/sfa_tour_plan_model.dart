

import 'dart:convert';

import 'package:nepali_date_picker/nepali_date_picker.dart';

SfaTourPlanModel sfaTourPlanModelFromJson(String str) => SfaTourPlanModel.fromJson(json.decode(str));

String sfaTourPlanModelToJson(SfaTourPlanModel data) => json.encode(data.toJson());

class SfaTourPlanModel {
    // final String? status;
    final List<SfaTourPlan>? data;

    SfaTourPlanModel({
        // this.status,
        this.data,
    });

    factory SfaTourPlanModel.fromJson(Map<String, dynamic> json) => SfaTourPlanModel(
        // status: json["status"],
        data: json["data"] == null ? [] : List<SfaTourPlan>.from(json["data"]!.map((x) => SfaTourPlan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        // "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SfaTourPlan {
    final int? id;
    final String? title;
    final String? startFrom;
    final String? endTo;
    final String? description;
    final NepaliDateTime? createdAt;
    final NepaliDateTime? updatedAt;
    final int? createdBy;
    final String? status;
    final dynamic statusNote;
    final String? note;
    final int? statusChangeBy;
    final String? createdByName;
    final List<Beat>? beats;
    final int? tourDays;
    SfaTourPlan({
        this.id,
        this.title,
        this.startFrom,
        this.endTo,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.status,
        this.statusNote,
        this.statusChangeBy,
        this.createdByName,
        this.beats,
        this.tourDays,
        this.note
    });

    factory SfaTourPlan.fromJson(Map<String, dynamic> json) => SfaTourPlan(
        id: json["id"],
        title: json["title"],
        startFrom: json["start_from"],
        endTo: json["end_to"],
        note: json["note"],
        description: json["description"],
        createdAt: json["created_at"] == null ? null : NepaliDateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : NepaliDateTime.tryParse(json["updated_at"]),
        createdBy: json["created_by"],
        status: json["status"],
        statusNote: json["status_note"],
        statusChangeBy: json["status_change_by"],
        createdByName: json["created_by_name"],
        tourDays: json["tour_days"],
        beats: json["beats"] == null ? [] : List<Beat>.from(json["beats"]!.map((x) => Beat.fromJson(x))),
    );


  Map<String, dynamic> toJson() => {
        "title": title,
        "start_from": startFrom,
        "end_to": endTo,
        "note": note,
        "description": description,
        "beat_id": beats == null ? [] : List<dynamic>.from(beats!.map((x) => x.id)),
    };
}

class Beat {
    final int? id;
    final String? name;
    final dynamic code;
    final dynamic description;
    final NepaliDateTime? createdAt;
    final NepaliDateTime? updatedAt;
    final int? dealerId;
    final dynamic beatPointId;
    final Pivot? pivot;

    Beat({
        this.id,
        this.name,
        this.code,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.dealerId,
        this.beatPointId,
        this.pivot,
    });

    factory Beat.fromJson(Map<String, dynamic> json) => Beat(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        description: json["description"],
        createdAt: json["created_at"] == null ? null : NepaliDateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : NepaliDateTime.tryParse(json["updated_at"]),
        dealerId: json["dealer_id"],
        beatPointId: json["beat_point_id"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        // "name": name,
        // "code": code,
        // "description": description,
        // "created_at": createdAt?.toIso8601String(),
        // "updated_at": updatedAt?.toIso8601String(),
        // "dealer_id": dealerId,
        // "beat_point_id": beatPointId,
        // "pivot": pivot?.toJson(),
    };
}

class Pivot {
    final int? tourplanId;
    final int? beatId;

    Pivot({
        this.tourplanId,
        this.beatId,
    });

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        tourplanId: json["tourplan_id"],
        beatId: json["beat_id"],
    );

    Map<String, dynamic> toJson() => {
        "tourplan_id": tourplanId,
        "beat_id": beatId,
    };
}

