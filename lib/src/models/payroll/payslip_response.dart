// To parse this JSON data, do
//
//     final payslipResponse = payslipResponseFromJson(jsonString);
import 'dart:convert';

List<PayslipResponse> payslipResponseFromJson(String str) => List<PayslipResponse>.from(json.decode(str).map((x) => PayslipResponse.fromJson(x)));

String payslipResponseToJson(List<PayslipResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PayslipResponse {
    final DateTime? fromDate;
    final DateTime? toDate;
    final String? type;
    final String? periodType;
    final dynamic considerOverTime;
    final String? generatingType;
    final dynamic id;
    final dynamic payrunId;
    final dynamic employeeId;
    final double? basicSalary;
    final dynamic allowance;
    final dynamic deduction;
    final double? tax;
    final String? comment;
    final String? note;
    final double? netSalary;
    final Details? details;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic status;
    final dynamic payrollId;
    final dynamic otSalary;
    final dynamic totalWeekendSalary;
    final dynamic totalPaidHolidaySalary;
    final dynamic totalPaidLeaveAmount;
    final double? grossSalary;

    PayslipResponse({
        this.fromDate,
        this.toDate,
        this.type,
        this.periodType,
        this.considerOverTime,
        this.generatingType,
        this.id,
        this.payrunId,
        this.employeeId,
        this.basicSalary,
        this.allowance,
        this.deduction,
        this.tax,
        this.comment,
        this.note,
        this.netSalary,
        this.details,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.payrollId,
        this.otSalary,
        this.totalWeekendSalary,
        this.totalPaidHolidaySalary,
        this.totalPaidLeaveAmount,
        this.grossSalary,
    });

    factory PayslipResponse.fromJson(Map<String, dynamic> json) => PayslipResponse(
        fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
        toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        type: json["type"],
        periodType: json["period_type"],
        considerOverTime: json["consider_over_time"],
        generatingType: json["generating_type"],
        id: json["id"],
        payrunId: json["payrun_id"],
        employeeId: json["employee_id"],
        basicSalary: json["basic_salary"]?.toDouble(),
        allowance: json["allowance"],
        deduction: json["deduction"],
        tax: json["tax"]?.toDouble(),
        comment: json["comment"],
        note: json["note"],
        netSalary: json["net_salary"]?.toDouble(),
        details: json["details"] == null ? null : Details.fromJson(json["details"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        status: json["status"],
        payrollId: json["payroll_id"],
        otSalary: json["ot_salary"],
        totalWeekendSalary: json["total_weekend_salary"],
        totalPaidHolidaySalary: json["total_paid_holiday_salary"],
        totalPaidLeaveAmount: json["total_paid_leave_amount"],
        grossSalary: json["gross_salary"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "from_date": "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date": "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "type": type,
        "period_type": periodType,
        "consider_over_time": considerOverTime,
        "generating_type": generatingType,
        "id": id,
        "payrun_id": payrunId,
        "employee_id": employeeId,
        "basic_salary": basicSalary,
        "allowance": allowance,
        "deduction": deduction,
        "tax": tax,
        "comment": comment,
        "note": note,
        "net_salary": netSalary,
        "details": details?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "payroll_id": payrollId,
        "ot_salary": otSalary,
        "total_weekend_salary": totalWeekendSalary,
        "total_paid_holiday_salary": totalPaidHolidaySalary,
        "total_paid_leave_amount": totalPaidLeaveAmount,
        "gross_salary": grossSalary,
    };
}

class Details {
    final Incentive? incentive;
    final List<dynamic>? payrollDetails;

    Details({
        this.incentive,
        this.payrollDetails,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        incentive: json["incentive"] == null ? null : Incentive.fromJson(json["incentive"]),
        payrollDetails: json["payroll_details"] == null ? [] : List<dynamic>.from(json["payroll_details"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "incentive": incentive?.toJson(),
        "payroll_details": payrollDetails == null ? [] : List<dynamic>.from(payrollDetails!.map((x) => x)),
    };
}

class Incentive {
    final int? holidayCount;
    final int? paidLeaveCount;
    final int? unpaidLeaveCount;
    final int? approvedCount;
    final int? totalWorkingDays;
    final int? weekends;
    final int? daysPresent;
    final DateTime? from;
    final DateTime? to;
    final int? workingHourPerDay;
    final double? totalWorkTime;
    final int? incompleteAttendance;
    final int? expectedWorkTime;
    final double? otHour;
    final Map<String, Calander>? calander;

    Incentive({
        this.holidayCount,
        this.paidLeaveCount,
        this.unpaidLeaveCount,
        this.approvedCount,
        this.totalWorkingDays,
        this.weekends,
        this.daysPresent,
        this.from,
        this.to,
        this.workingHourPerDay,
        this.totalWorkTime,
        this.incompleteAttendance,
        this.expectedWorkTime,
        this.otHour,
        this.calander,
    });

    factory Incentive.fromJson(Map<String, dynamic> json) => Incentive(
        holidayCount: json["holidayCount"],
        paidLeaveCount: json["paidLeaveCount"],
        unpaidLeaveCount: json["unpaidLeaveCount"],
        approvedCount: json["approvedCount"],
        totalWorkingDays: json["totalWorkingDays"],
        weekends: json["weekends"],
        daysPresent: json["daysPresent"],
        from: json["from"] == null ? null : DateTime.parse(json["from"]),
        to: json["to"] == null ? null : DateTime.parse(json["to"]),
        workingHourPerDay: json["workingHourPerDay"],
        totalWorkTime: json["totalWorkTime"]?.toDouble(),
        incompleteAttendance: json["incompleteAttendance"],
        expectedWorkTime: json["expectedWorkTime"],
        otHour: json["otHour"]?.toDouble(),
        //calander: Map.from(json["calander"]!).map((k, v) => MapEntry<String, Calander>(k, Calander.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "holidayCount": holidayCount,
        "paidLeaveCount": paidLeaveCount,
        "unpaidLeaveCount": unpaidLeaveCount,
        "approvedCount": approvedCount,
        "totalWorkingDays": totalWorkingDays,
        "weekends": weekends,
        "daysPresent": daysPresent,
        "from": "${from!.year.toString().padLeft(4, '0')}-${from!.month.toString().padLeft(2, '0')}-${from!.day.toString().padLeft(2, '0')}",
        "to": "${to!.year.toString().padLeft(4, '0')}-${to!.month.toString().padLeft(2, '0')}-${to!.day.toString().padLeft(2, '0')}",
        "workingHourPerDay": workingHourPerDay,
        "totalWorkTime": totalWorkTime,
        "incompleteAttendance": incompleteAttendance,
        "expectedWorkTime": expectedWorkTime,
        "otHour": otHour,
        "calander": Map.from(calander!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class Calander {
    final int? isHoliday;
    final int? isWeekend;
    final dynamic workTime;
    final int? tookLeave;
    final dynamic leaveInfo;
    final int? wasPresent;
    final dynamic attendance;
    final List<Detail>? details;

    Calander({
        this.isHoliday,
        this.isWeekend,
        this.workTime,
        this.tookLeave,
        this.leaveInfo,
        this.wasPresent,
        this.attendance,
        this.details,
    });

    factory Calander.fromJson(Map<String, dynamic> json) => Calander(
        isHoliday: json["is_holiday"],
        isWeekend: json["is_weekend"],
        workTime: json["work_time"],
        tookLeave: json["took_leave"],
        leaveInfo: json["leave_info"],
        wasPresent: json["was_present"],
        attendance: json["attendance"],
        details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "is_holiday": isHoliday,
        "is_weekend": isWeekend,
        "work_time": workTime,
        "took_leave": tookLeave,
        "leave_info": leaveInfo,
        "was_present": wasPresent,
        "attendance": attendance,
        "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
    };
}

class Detail {
    final int? id;
    final int? attendanceId;
    final DateTime? attendanceDate;
    final dynamic deviceId;
    final int? state;
    final dynamic lat;
    final dynamic long;
    final dynamic method;

    Detail({
        this.id,
        this.attendanceId,
        this.attendanceDate,
        this.deviceId,
        this.state,
        this.lat,
        this.long,
        this.method,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        attendanceId: json["attendance_id"],
        attendanceDate: json["attendance_date"] == null ? null : DateTime.parse(json["attendance_date"]),
        deviceId: json["device_id"],
        state: json["state"],
        lat: json["lat"],
        long: json["long"],
        method: json["method"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attendance_id": attendanceId,
        "attendance_date": attendanceDate?.toIso8601String(),
        "device_id": deviceId,
        "state": state,
        "lat": lat,
        "long": long,
        "method": method,
    };
}