
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

// User userFromJson(String str) => User.fromJson(json.decode(str));

// String userToJson(User data) => json.encode(data.toJson());

@freezed
abstract class User with _$User {
    const factory User({
        required int? id,
        required String? name,
        required String? gender,
        required String? role,
        required dynamic father_name,
        required dynamic mother_name,
        required dynamic spouse_name,
        required String? email,
        required dynamic present_address,
        required dynamic permanent_address,
        required String? contact_no_one,
        required String? phone,
        required dynamic contact_no_two,
        required DateTime? date_of_birth,
        required String? avatar,
        required dynamic department_id,
        required dynamic designation_id,
        required dynamic joining_date,
        required dynamic department_name,
        required String? designation_name,
        required dynamic enable_attendance_from_mobile,
        required dynamic enable_live_tracking,
        required List<AttendanceBoundary>? attendance_boundary,
        required final List<Shift>? shifts,
    }) = _User;

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
class AttendanceBoundary {
    final String? latitude;
    final String? longitude;
    final String? radius;
    final String? elevation;

    AttendanceBoundary({
        this.latitude,
        this.longitude,
        this.radius,
        this.elevation,
    });

    factory AttendanceBoundary.fromJson(Map<String, dynamic> json) => AttendanceBoundary(
        latitude: json["latitude"],
        longitude: json["longitude"],
        radius: json["radius"],
        elevation: json["elevation"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "radius": radius,
        "elevation": elevation,
    };
}

class Shift {
    final int? id;
    final int? userId;
    final String? shiftName;
    final String? description;
    final DateTime? startDate;
    final String? startTime;
    final String? graceStart;
    final DateTime? endDate;
    final String? endTime;
    final String? graceEnd;
    final String? lunchOut;
    final String? lunchIn;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? laravelThroughKey;

    Shift({
        this.id,
        this.userId,
        this.shiftName,
        this.description,
        this.startDate,
        this.startTime,
        this.graceStart,
        this.endDate,
        this.endTime,
        this.graceEnd,
        this.lunchOut,
        this.lunchIn,
        this.createdAt,
        this.updatedAt,
        this.laravelThroughKey,
    });

    factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["id"],
        userId: json["user_id"],
        shiftName: json["shift_name"],
        description: json["description"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        startTime: json["start_time"],
        graceStart: json["grace_start"],
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        endTime: json["end_time"],
        graceEnd: json["grace_end"],
        lunchOut: json["lunch_out"],
        lunchIn: json["lunch_in"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        laravelThroughKey: json["laravel_through_key"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "shift_name": shiftName,
        "description": description,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "grace_start": graceStart,
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "end_time": endTime,
        "grace_end": graceEnd,
        "lunch_out": lunchOut,
        "lunch_in": lunchIn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "laravel_through_key": laravelThroughKey,
    };
}