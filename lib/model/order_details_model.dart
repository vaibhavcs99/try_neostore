// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
    OrderDetailsModel({
        this.status,
        this.data,
    });

    final int status;
    final Data data;

    factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.cost,
        this.address,
        this.orderDetails,
    });

    final int id;
    final int cost;
    final String address;
    final List<OrderDetail> orderDetails;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        cost: json["cost"] == null ? null : json["cost"],
        address: json["address"] == null ? null : json["address"],
        orderDetails: json["order_details"] == null ? null : List<OrderDetail>.from(json["order_details"].map((x) => OrderDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "cost": cost == null ? null : cost,
        "address": address == null ? null : address,
        "order_details": orderDetails == null ? null : List<dynamic>.from(orderDetails.map((x) => x.toJson())),
    };
}

class OrderDetail {
    OrderDetail({
        this.id,
        this.orderId,
        this.productId,
        this.quantity,
        this.total,
        this.prodName,
        this.prodCatName,
        this.prodImage,
    });

    final int id;
    final int orderId;
    final int productId;
    final int quantity;
    final int total;
    final String prodName;
    final String prodCatName;
    final String prodImage;

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"] == null ? null : json["id"],
        orderId: json["order_id"] == null ? null : json["order_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        total: json["total"] == null ? null : json["total"],
        prodName: json["prod_name"] == null ? null : json["prod_name"],
        prodCatName: json["prod_cat_name"] == null ? null : json["prod_cat_name"],
        prodImage: json["prod_image"] == null ? null : json["prod_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "order_id": orderId == null ? null : orderId,
        "product_id": productId == null ? null : productId,
        "quantity": quantity == null ? null : quantity,
        "total": total == null ? null : total,
        "prod_name": prodName == null ? null : prodName,
        "prod_cat_name": prodCatName == null ? null : prodCatName,
        "prod_image": prodImage == null ? null : prodImage,
    };
}
