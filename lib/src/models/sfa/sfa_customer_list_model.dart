// To parse this JSON data, do
//
//     final sfaCustomerListModel = sfaCustomerListModelFromJson(jsonString);

import 'dart:convert';

SfaCustomerList sfaCustomerListModelFromJson(String str) => SfaCustomerList.fromJson(json.decode(str));

class SfaCustomerListModel {
  int id;
  String name;
  String? email;
  String? address;
  String contact;
  String? emergencyContact;
  dynamic avatar; // You may need to specify the type here based on the actual data
  int branchId;
  int? beatId;
  dynamic lat;
  dynamic long;
  String? beatName;
  dynamic totalOrderAmount;
  int? totalOrderQty;
  dynamic totalPaymentAmount;
  String clientType;

  SfaCustomerListModel({
    required this.id,
    required this.name,
    this.email,
    this.address,
    required this.contact,
    this.emergencyContact,
    this.avatar,
    required this.branchId,
    this.beatId,
    this.lat,
    this.long,
    this.beatName,
    this.totalOrderAmount,
    this.totalOrderQty,
    this.totalPaymentAmount,
    required this.clientType,
  });

  factory SfaCustomerListModel.fromJson(Map<String, dynamic> json) {
    return SfaCustomerListModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      contact: json['contact'],
      emergencyContact: json['emergency_contact'],
      avatar: json['avatar'],
      branchId: json['branch_id'],
      beatId: json['beat_id'],
      lat: json['lat'],
      long: json['long'],
      beatName: json['beat_name'],
      totalOrderAmount: json['total_order_amount'],
      totalOrderQty: json['total_order_qty'],
      totalPaymentAmount: json['total_payment_amount'],
      clientType: json['client_type'],
    );
  }
}

class SfaCustomerList {
  Map<String, List<SfaCustomerListModel>> clientLists;
 
  SfaCustomerList({
    required this.clientLists,
    
  });

  factory SfaCustomerList.fromJson(Map<String, dynamic> json) {
    Map<String, List<SfaCustomerListModel>> clientLists = {};
    json.forEach((key, value) {
      
      clientLists[key] = List<SfaCustomerListModel>.from(value.map((x) => SfaCustomerListModel.fromJson(x)));
      
    });

    return SfaCustomerList(clientLists: clientLists);
  }

   // Factory method to create SfaCustomerList from MapEntry list
  factory SfaCustomerList.fromMapEntryList(
      List<MapEntry<String, List<SfaCustomerListModel>>> entryList) {
    Map<String, List<SfaCustomerListModel>> clientLists = Map.fromEntries(entryList);
    return SfaCustomerList(clientLists: clientLists);
  }
}

