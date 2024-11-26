// To parse this JSON data, do
//
//     final sfaProductModel = sfaProductModelFromJson(jsonString);

import 'dart:convert';

SfaProductModel sfaProductModelFromJson(String str) =>
    SfaProductModel.fromJson(json.decode(str));

String sfaProductModelToJson(SfaProductModel data) =>
    json.encode(data.toJson());

class SfaProductModel {
  final int? currentPage;
   List<SfaProduct>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  SfaProductModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory SfaProductModel.fromJson(Map<String, dynamic> json) =>
      SfaProductModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<SfaProduct>.from(
                json["data"]!.map((x) => SfaProduct.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };


}

class SfaProduct {
  final int? id;
  int? itemId;
  String? name;
  dynamic price;
  dynamic sellingPrice;
  String? description;
  String? code;
  bool? isSelected;
   dynamic askQuantity;
   dynamic availableQuantity;

  SfaProduct({
    this.id,
    this.itemId,
    this.name,
    this.code,
    this.price,
    this.sellingPrice,
    this.description,
    this.askQuantity,
    this.availableQuantity,
    this.isSelected
  });

  factory SfaProduct.fromJson(Map<String, dynamic> json) => SfaProduct(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        code: json['code'],
        description: json["description"],
        sellingPrice: json['selling_price'] ?? json["price"],
        askQuantity: 0,
        availableQuantity: 0,
        isSelected: false
      );

  Map<String, dynamic> toJson() => {
        "id":itemId,
        "product_id": id,
        "available_qty": availableQuantity,
        "ask_qty": askQuantity,
        "selling_price":sellingPrice
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
