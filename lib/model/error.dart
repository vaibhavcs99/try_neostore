// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
    ErrorModel({
        this.status,
        this.message,
        this.userMsg,
    });

    final int status;
    final String message;
    final String userMsg;

    factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        userMsg: json["user_msg"] == null ? null : json["user_msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "user_msg": userMsg == null ? null : userMsg,
    };
}
