// To parse this JSON data, do
//
//     final cartListModel = cartListModelFromJson(jsonString);

import 'dart:convert';

CartListModel cartListModelFromJson(String str) => CartListModel.fromJson(json.decode(str));

String cartListModelToJson(CartListModel data) => json.encode(data.toJson());

class CartListModel {
    CartListModel({
        this.status,
        this.data,
        this.count,
        this.total,
    });

    final int status;
    final List<Datum> data;
    final int count;
    final int total;

    factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
        total: json["total"] == null ? null : json["total"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count == null ? null : count,
        "total": total == null ? null : total,
    };
}

class Datum {
    Datum({
        this.id,
        this.productId,
        this.quantity,
        this.product,
    });

    final int id;
    final int productId;
    final int quantity;
    final Product product;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "quantity": quantity == null ? null : quantity,
        "product": product == null ? null : product.toJson(),
    };
}

class Product {
    Product({
        this.id,
        this.name,
        this.cost,
        this.productCategory,
        this.productImages,
        this.subTotal,
    });

    final int id;
    final String name;
    final int cost;
    final String productCategory;
    final String productImages;
    final int subTotal;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        cost: json["cost"] == null ? null : json["cost"],
        productCategory: json["product_category"] == null ? null : json["product_category"],
        productImages: json["product_images"] == null ? null : json["product_images"],
        subTotal: json["sub_total"] == null ? null : json["sub_total"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "cost": cost == null ? null : cost,
        "product_category": productCategory == null ? null : productCategory,
        "product_images": productImages == null ? null : productImages,
        "sub_total": subTotal == null ? null : subTotal,
    };
}
