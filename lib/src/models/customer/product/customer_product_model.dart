// To parse this JSON data, do
//
//     final customerProductModel = customerProductModelFromJson(jsonString);

import 'dart:convert';

CustomerProductModel customerProductModelFromJson(String str) => CustomerProductModel.fromJson(json.decode(str));
String customerProductModelToJson(CustomerProductModel data) => json.encode(data.toJson());

class CustomerProductModel {
    final List<ProductModel>? data;

    CustomerProductModel({
        this.data,
    });
    
    factory CustomerProductModel.fromJson(Map<String, dynamic> json) => CustomerProductModel(
        data: json["data"] == null ? [] : List<ProductModel>.from(json["data"]!.map((x) => ProductModel
        .fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ProductModel {
    final int? id;
    final String? name;
    final String? code;
    final int? price;
    final int? sellingPrice;
    final String? description;
    int quantity = 1;

    double get total => quantity * double.parse(sellingPrice.toString());

    void increment() => quantity++;
    void decrement() => quantity--;
    ProductModel({
        this.id,
        this.name,
        this.code,
        this.price,
        this.sellingPrice,
        this.description,
        required this.quantity
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        price: json["price"],
        sellingPrice: json["selling_price"] ?? json["price"],
        description: json["description"],
        quantity:1
    );

    Map<String, dynamic> toJson() => {
        "product_id": id,
        "ask_qty": quantity,
    };
}

