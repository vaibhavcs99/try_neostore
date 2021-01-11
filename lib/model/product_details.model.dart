// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
    ProductDetailsModel({
        this.status,
        this.data,
    });

    final int status;
    final Data data;

    factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
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
    final List<ProductImage> productImages;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        productImages: json["product_images"] == null ? null : List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
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
        "product_images": productImages == null ? null : List<dynamic>.from(productImages.map((x) => x.toJson())),
    };
}

class ProductImage {
    ProductImage({
        this.id,
        this.productId,
        this.image,
        this.created,
        this.modified,
    });

    final int id;
    final int productId;
    final String image;
    final String created;
    final String modified;

    factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        image: json["image"] == null ? null : json["image"],
        created: json["created"] == null ? null : json["created"],
        modified: json["modified"] == null ? null : json["modified"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "image": image == null ? null : image,
        "created": created == null ? null : created,
        "modified": modified == null ? null : modified,
    };
}
