// To parse this JSON data, do
//
//     final productsListModel = productsListModelFromJson(jsonString);

import 'dart:convert';

ProductsListModel productsListModelFromJson(String str) => ProductsListModel.fromJson(json.decode(str));

String productsListModelToJson(ProductsListModel data) => json.encode(data.toJson());

class ProductsListModel {
    ProductsListModel({
        this.status,
        this.data,
    });

    final int status;
    final List<Datum> data;

    factory ProductsListModel.fromJson(Map<String, dynamic> json) => ProductsListModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.productCategoryId,
        this.name,
        this.producer,
        this.description,
        this.cost,
        this.rating,
        this.viewCount,
        this.created,
        this.modified,
        this.productImages,
    });

    final int id;
    final int productCategoryId;
    final String name;
    final String producer;
    final String description;
    final int cost;
    final int rating;
    final int viewCount;
    final String created;
    final String modified;
    final String productImages;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        productCategoryId: json["product_category_id"] == null ? null : json["product_category_id"],
        name: json["name"] == null ? null : json["name"],
        producer: json["producer"] == null ? null : json["producer"],
        description: json["description"] == null ? null : json["description"],
        cost: json["cost"] == null ? null : json["cost"],
        rating: json["rating"] == null ? null : json["rating"],
        viewCount: json["view_count"] == null ? null : json["view_count"],
        created: json["created"] == null ? null : json["created"],
        modified: json["modified"] == null ? null : json["modified"],
        productImages: json["product_images"] == null ? null : json["product_images"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_category_id": productCategoryId == null ? null : productCategoryId,
        "name": name == null ? null : name,
        "producer": producer == null ? null : producer,
        "description": description == null ? null : description,
        "cost": cost == null ? null : cost,
        "rating": rating == null ? null : rating,
        "view_count": viewCount == null ? null : viewCount,
        "created": created == null ? null : created,
        "modified": modified == null ? null : modified,
        "product_images": productImages == null ? null : productImages,
    };
}
