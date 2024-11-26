// To parse this JSON data, do
//
//     final sfaDashBoardModel = sfaDashBoardModelFromJson(jsonString);

import 'dart:convert';

SfaDashBoardModel sfaDashBoardModelFromJson(String str) => SfaDashBoardModel.fromJson(json.decode(str));

String sfaDashBoardModelToJson(SfaDashBoardModel data) => json.encode(data.toJson());

class SfaDashBoardModel {
    final OrderSummery? orderSummery;
  final int? noOfAssignParty;
    final int? noOfBeat;
    final int? tourPlanToday;

    SfaDashBoardModel({
        this.orderSummery,
        this.noOfAssignParty,
        this.noOfBeat,
        this.tourPlanToday,
    });

    factory SfaDashBoardModel.fromJson(Map<String, dynamic> json) => SfaDashBoardModel(
        orderSummery: json["order_summery"] == null ? null : OrderSummery.fromJson(json["order_summery"]),
        noOfAssignParty: json["no_of_assign_party"],
        noOfBeat: json["no_of_beat"],
        tourPlanToday: json["tour_plan_today"],
    );

    Map<String, dynamic> toJson() => {
        "order_summery": orderSummery?.toJson(),
        "no_of_assign_party": noOfAssignParty,
        "no_of_beat": noOfBeat,
        "tour_plan_today": tourPlanToday,
    };
}

class OrderSummery {
    final int? totalDispatchQty;
    final int? totalAskQty;
     dynamic totalDispatchAmount;
    dynamic totalAskAmount;

    OrderSummery({
        this.totalDispatchQty,
        this.totalAskQty,
        this.totalDispatchAmount,
        this.totalAskAmount,
    });

    factory OrderSummery.fromJson(Map<String, dynamic> json) => OrderSummery(
        totalDispatchQty: json["total_dispatch_qty"],
        totalAskQty: json["total_ask_qty"],
        totalDispatchAmount: json["total_dispatch_amount"],
        totalAskAmount: json["total_ask_amount"],
    );

    Map<String, dynamic> toJson() => {
        "total_dispatch_qty": totalDispatchQty,
        "total_ask_qty": totalAskQty,
        "total_dispatch_amount": totalDispatchAmount,
        "total_ask_amount": totalAskAmount,
    };
}
