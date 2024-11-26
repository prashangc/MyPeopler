// To parse this JSON data, do
//
//     final responseMessage = responseMessageFromJson(jsonString);

import 'dart:convert';

ResponseMessage responseMessageFromJson(String str) => ResponseMessage.fromJson(json.decode(str));

String responseMessageToJson(ResponseMessage data) => json.encode(data.toJson());

class ResponseMessage {
    ResponseMessage({
        this.message,
    });

    String? message;

    factory ResponseMessage.fromJson(Map<String, dynamic> json) => ResponseMessage(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
