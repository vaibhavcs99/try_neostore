// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);

import 'dart:convert';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
    Error({
        this.status,
        this.data,
        this.message,
        this.userMsg,
    });

    final int status;
    final bool data;
    final String message;
    final String userMsg;

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : json["data"],
        message: json["message"] == null ? null : json["message"],
        userMsg: json["user_msg"] == null ? null : json["user_msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data,
        "message": message == null ? null : message,
        "user_msg": userMsg == null ? null : userMsg,
    };
}
