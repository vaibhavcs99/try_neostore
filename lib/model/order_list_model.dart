// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) => OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
    OrderListModel({
        this.status,
        this.data,
        this.message,
        this.userMsg,
    });

    final int status;
    final List<Datum> data;
    final String message;
    final String userMsg;

    factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
        userMsg: json["user_msg"] == null ? null : json["user_msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
        "user_msg": userMsg == null ? null : userMsg,
    };
}

class Datum {
    Datum({
        this.id,
        this.cost,
        this.created,
    });

    final int id;
    final int cost;
    final String created;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        cost: json["cost"] == null ? null : json["cost"],
        created: json["created"] == null ? null : json["created"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "cost": cost == null ? null : cost,
        "created": created == null ? null : created,
    };
}
