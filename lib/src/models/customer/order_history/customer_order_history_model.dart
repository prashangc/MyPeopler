// To parse this JSON data, do
//
//     final customerOrderHistoryModel = customerOrderHistoryModelFromJson(jsonString);

import 'dart:convert';

CustomerOrderHistoryModel customerOrderHistoryModelFromJson(String str) => CustomerOrderHistoryModel.fromJson(json.decode(str));

String customerOrderHistoryModelToJson(CustomerOrderHistoryModel data) => json.encode(data.toJson());

class CustomerOrderHistoryModel {
    final List<CustomerOrderHistoryData>? data;

    CustomerOrderHistoryModel({
        this.data,
    });

    factory CustomerOrderHistoryModel.fromJson(Map<String, dynamic> json) => CustomerOrderHistoryModel(
        data: json["data"] == null ? [] : List<CustomerOrderHistoryData>.from(json["data"]!.map((x) => CustomerOrderHistoryData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CustomerOrderHistoryData {
    final int? id;
    final String? orderNumber;
    final int? customerId;
    final int? availableQty;
    final int? askQty;
    final int? total;
    final String? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic employeeId;
    final dynamic statusChangeBy;
    final dynamic statusNote;
    final dynamic long;
    final dynamic lat;
    final List<Item>? items;
    CustomerOrderHistoryData({
        this.id,
        this.orderNumber,
        this.customerId,
        this.availableQty,
        this.askQty,
        this.total,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.employeeId,
        this.statusChangeBy,
        this.statusNote,
        this.long,
        this.lat,
        this.items,
    });

    factory CustomerOrderHistoryData.fromJson(Map<String, dynamic> json) {
      
      return CustomerOrderHistoryData(
        id: json["id"],
        orderNumber: json["order_number"],
        customerId: json["customer_id"],
        availableQty: json["available_qty"],
        askQty: json["ask_qty"],
        total: json["total"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        employeeId: json["employee_id"],
        statusChangeBy: json["status_change_by"],
        statusNote: json["status_note"],
        long: json["long"],
        lat: json["lat"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) {
          return Item.fromJson(x);
        })),
        );
    }
    

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
        "customer_id": customerId,
        "available_qty": availableQty,
        "ask_qty": askQty,
        "total": total,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "employee_id": employeeId,
        "status_change_by": statusChangeBy,
        "status_note": statusNote,
        "long": long,
        "lat": lat,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    final String? productName;
    final String? productCode;
    final int? id;
    final int? orderId;
    final int? productId;
    final int? availableQty;
    final int? askQty;
    final int? price;
    final int? total;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic dispatchQty;

    Item({
        this.productName,
        this.productCode,
        this.id,
        this.orderId,
        this.productId,
        this.availableQty,
        this.askQty,
        this.price,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.dispatchQty,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        productName: json["product_name"],
        productCode: json["product_code"],
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        availableQty: json["available_qty"],
        askQty: json["ask_qty"],
        price: json["price"],
        total: json["total"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        dispatchQty: json["dispatch_qty"],
    );

    Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_code": productCode,
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "available_qty": availableQty,
        "ask_qty": askQty,
        "price": price,
        "total": total,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "dispatch_qty": dispatchQty,
    };
}
