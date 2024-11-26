// To parse this JSON data, do
//
//     final customerLoginModel = customerLoginModelFromJson(jsonString);

import 'dart:convert';

CustomerLoginModel customerLoginModelFromJson(String str) => CustomerLoginModel.fromJson(json.decode(str));

String customerLoginModelToJson(CustomerLoginModel data) => json.encode(data.toJson());

class CustomerLoginModel {
    final String? message;
    final String? token;
    final Customer? customer;

    CustomerLoginModel({
        this.message,
        this.token,
        this.customer,
    });

    factory CustomerLoginModel.fromJson(Map<String, dynamic> json) => CustomerLoginModel(
        message: json["message"],
        token: json["token"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "customer": customer?.toJson(),
    };
}

class Customer {
    final int? id;
    final int? createdBy;
    final String? name;
    final String? email;
    final String? password;
    final String? contact;
    final dynamic emergencyContact;
    final dynamic web;
    final dynamic avatar;
    final int? clientTypeId;
    final int? activationStatus;
    final dynamic rememberToken;
    final int? branchId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic deletedAt;
    final int? beatId;
    final dynamic lat;
    final dynamic long;
    final dynamic address;
    final dynamic establishYear;
    final dynamic description;
    final dynamic contactName;
    final dynamic contactEmail;
    final dynamic contactPhone;
    final dynamic contactGender;
    final dynamic panVat;
    final dynamic contactPosition;
    final int? isRequest;
    final dynamic visitPeriodId;
    final String? group;

    Customer({
        this.id,
        this.createdBy,
        this.name,
        this.email,
        this.password,
        this.contact,
        this.emergencyContact,
        this.web,
        this.avatar,
        this.clientTypeId,
        this.activationStatus,
        this.rememberToken,
        this.branchId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.beatId,
        this.lat,
        this.long,
        this.address,
        this.establishYear,
        this.description,
        this.contactName,
        this.contactEmail,
        this.contactPhone,
        this.contactGender,
        this.panVat,
        this.contactPosition,
        this.isRequest,
        this.visitPeriodId,
        this.group,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        createdBy: json["created_by"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        contact: json["contact"],
        emergencyContact: json["emergency_contact"],
        web: json["web"],
        avatar: json["avatar"],
        clientTypeId: json["client_type_id"],
        activationStatus: json["activation_status"],
        rememberToken: json["remember_token"],
        branchId: json["branch_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        beatId: json["beat_id"],
        lat: json["lat"],
        long: json["long"],
        address: json["address"],
        establishYear: json["establish_year"],
        description: json["description"],
        contactName: json["contact_name"],
        contactEmail: json["contact_email"],
        contactPhone: json["contact_phone"],
        contactGender: json["contact_gender"],
        panVat: json["pan_vat"],
        contactPosition: json["contact_position"],
        isRequest: json["is_request"],
        visitPeriodId: json["visit_period_id"],
        group: json["group"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "name": name,
        "email": email,
        "password": password,
        "contact": contact,
        "emergency_contact": emergencyContact,
        "web": web,
        "avatar": avatar,
        "client_type_id": clientTypeId,
        "activation_status": activationStatus,
        "remember_token": rememberToken,
        "branch_id": branchId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "beat_id": beatId,
        "lat": lat,
        "long": long,
        "address": address,
        "establish_year": establishYear,
        "description": description,
        "contact_name": contactName,
        "contact_email": contactEmail,
        "contact_phone": contactPhone,
        "contact_gender": contactGender,
        "pan_vat": panVat,
        "contact_position": contactPosition,
        "is_request": isRequest,
        "visit_period_id": visitPeriodId,
        "group": group,
    };
}
