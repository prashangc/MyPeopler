// To parse this JSON data, do
//
//     final marketSchemeModel = marketSchemeModelFromJson(jsonString);

import 'dart:convert';

MarketSchemeModel marketSchemeModelFromJson(String str) => MarketSchemeModel.fromJson(json.decode(str));

String marketSchemeModelToJson(MarketSchemeModel data) => json.encode(data.toJson());

class MarketSchemeModel {
    List<Datum> data;

    MarketSchemeModel({
        required this.data,
    });

    factory MarketSchemeModel.fromJson(Map<String, dynamic> json) => MarketSchemeModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String title;
    String fromDate;
    String toDate;
    int createdBy;
    String status;
    String customerName;
    List<Customer> customers;
    // List<Item> items;

    Datum({
        required this.id,
        required this.title,
        required this.fromDate,
        required this.toDate,
        required this.createdBy,
        required this.status,
        required this.customerName,
        required this.customers,
        // required this.items,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        createdBy: json["created_by"],
        status: json["status"],
        customerName: json["customer_name"],
        customers: List<Customer>.from(json["customers"].map((x) => Customer.fromJson(x))),
        // items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "from_date": fromDate,
        "to_date": toDate,
        "created_by": createdBy,
        "status": status,
        "customer_name": customerName,
        "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
        // "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Customer {
    int id;
    String name;
    // Pivot pivot;

    Customer({
        required this.id,
        required this.name,
        // required this.pivot,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        // pivot: Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        // "pivot": pivot.toJson(),
    };
}

class Pivot {
    int marketingSchemeId;
    int customerId;

    Pivot({
        required this.marketingSchemeId,
        required this.customerId,
    });

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        marketingSchemeId: json["marketing_scheme_id"],
        customerId: json["customer_id"],
    );

    Map<String, dynamic> toJson() => {
        "marketing_scheme_id": marketingSchemeId,
        "customer_id": customerId,
    };
}

class Item {
    int marketingSchemeId;
    int id;
    int? productId;
    dynamic productCategoryId;
    String name;
    String amount;
    String type;
    int? regularPrice;

    Item({
        required this.marketingSchemeId,
        required this.id,
        required this.productId,
        required this.productCategoryId,
        required this.name,
        required this.amount,
        required this.type,
        required this.regularPrice
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        marketingSchemeId: json["marketing_scheme_id"],
        id: json["id"],
        productId: json["product_id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        amount: json["amount"],
        type: json["type"],
        regularPrice: json['regular_price']
    );

    Map<String, dynamic> toJson() => {
        "marketing_scheme_id": marketingSchemeId,
        "id": id,
        "product_id": productId,
        "product_category_id": productCategoryId,
        "name": name,
        "amount": amount,
        "type": type,
        "regular_price": regularPrice
    };
}
