// To parse this JSON data, do
//
//     final sfaProductOrderReport = sfaProductOrderReportFromJson(jsonString);

import 'dart:convert';

SfaProductOrderReport sfaProductOrderReportFromJson(String str) =>
    SfaProductOrderReport.fromJson(json.decode(str));

String sfaProductOrderReportToJson(SfaProductOrderReport data) =>
    json.encode(data.toJson());

class SfaProductOrderReport {
  final List<ProductOrderReport>? data;

  SfaProductOrderReport({
    this.data,
  });

  factory SfaProductOrderReport.fromJson(Map<String, dynamic> json) =>
      SfaProductOrderReport(
        data: json["data"] == null
            ? []
            : List<ProductOrderReport>.from(
                json["data"]!.map((x) => ProductOrderReport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProductOrderReport {
  final int? id;
  final DateTime? createdAt;
  final String? status;
  final String? clientType;
  final String? orderNumber;
  final String? orderType;
  final int? employeeId;
  final String? employeeName;
  final int? customerId;
  final String? customerName;
  final String? customerContact;
  final String? dealerName;
  final String? beatName;
  final dynamic beatPointName;
  final List<ProductOrderReportItem>? items;

  ProductOrderReport({
    this.id,
    this.createdAt,
    this.status,
    this.clientType,
    this.orderNumber,
    this.orderType,
    this.employeeId,
    this.employeeName,
    this.customerId,
    this.customerName,
    this.customerContact,
    this.dealerName,
    this.beatName,
    this.beatPointName,
    this.items,
  });

  factory ProductOrderReport.fromJson(Map<String, dynamic> json) =>
      ProductOrderReport(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        status: json["status"],
        clientType: json["client_type"],
        orderNumber: json["order_number"],
        orderType: json["order_type"],
        employeeId: json["employee_id"],
        employeeName: json["employee_name"],
        customerId: json["customer_id"],
        customerName: json["customer_name"],
        customerContact: json["customer_contact"],
        dealerName: json["dealer_name"],
        beatName: json["beat_name"],
        beatPointName: json["beat_point_name"],
        items: json["items"] == null
            ? []
            : List<ProductOrderReportItem>.from(
                json["items"]!.map((x) => ProductOrderReportItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "status": status,
        "client_type": clientType,
        "order_number": orderNumber,
        "order_type": orderType,
        "employee_id": employeeId,
        "employee_name": employeeName,
        "customer_id": customerId,
        "customer_name": customerName,
        "customer_contact": customerContact,
        "dealer_name": dealerName,
        "beat_name": beatName,
        "beat_point_name": beatPointName,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class ProductOrderReportItem {
  final int? id;
  final int? orderId;
  int? productId;
  String? productName;
  String? productCode;
  int? availableQty;
  int? askQty;
  double? price;
  double? total;
  double? dispatchQty;

  ProductOrderReportItem({
    this.id,
    this.orderId,
    this.productId,
    this.productName,
    this.productCode,
    this.availableQty,
    this.askQty,
    this.price,
    this.total,
    this.dispatchQty,
  });

  factory ProductOrderReportItem.fromJson(Map<String, dynamic> json) =>
      ProductOrderReportItem(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        productCode: json["product_code"],
        availableQty: json["available_qty"],
        askQty: json["ask_qty"],
        price: json["price"]?.toDouble(),
        total: json["total"]?.toDouble(),
        dispatchQty: json["dispatch_qty"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "available_qty": availableQty ?? 0,
        "ask_qty": askQty ?? 0,
        "selling_price": price ?? 0,
        "price": price ?? 0
      };
}
