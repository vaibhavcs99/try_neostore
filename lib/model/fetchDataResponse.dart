// To parse this JSON data, do
//
//     final fetchDataResponse = fetchDataResponseFromJson(jsonString);

import 'dart:convert';

FetchDataResponse fetchDataResponseFromJson(String str) => FetchDataResponse.fromJson(json.decode(str));

String fetchDataResponseToJson(FetchDataResponse data) => json.encode(data.toJson());

class FetchDataResponse {
    FetchDataResponse({
        this.status,
        this.data,
    });

    final int status;
    final Data data;

    factory FetchDataResponse.fromJson(Map<String, dynamic> json) => FetchDataResponse(
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
        this.userData,
        this.productCategories,
        this.totalCarts,
        this.totalOrders,
    });

    final UserData userData;
    final List<ProductCategory> productCategories;
    final int totalCarts;
    final int totalOrders;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: json["user_data"] == null ? null : UserData.fromJson(json["user_data"]),
        productCategories: json["product_categories"] == null ? null : List<ProductCategory>.from(json["product_categories"].map((x) => ProductCategory.fromJson(x))),
        totalCarts: json["total_carts"] == null ? null : json["total_carts"],
        totalOrders: json["total_orders"] == null ? null : json["total_orders"],
    );

    Map<String, dynamic> toJson() => {
        "user_data": userData == null ? null : userData.toJson(),
        "product_categories": productCategories == null ? null : List<dynamic>.from(productCategories.map((x) => x.toJson())),
        "total_carts": totalCarts == null ? null : totalCarts,
        "total_orders": totalOrders == null ? null : totalOrders,
    };
}

class ProductCategory {
    ProductCategory({
        this.id,
        this.name,
        this.iconImage,
        this.created,
        this.modified,
    });

    final int id;
    final String name;
    final String iconImage;
    final String created;
    final String modified;

    factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        iconImage: json["icon_image"] == null ? null : json["icon_image"],
        created: json["created"] == null ? null : json["created"],
        modified: json["modified"] == null ? null : json["modified"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "icon_image": iconImage == null ? null : iconImage,
        "created": created == null ? null : created,
        "modified": modified == null ? null : modified,
    };
}

class UserData {
    UserData({
        this.id,
        this.roleId,
        this.firstName,
        this.lastName,
        this.email,
        this.username,
        this.profilePic,
        this.countryId,
        this.gender,
        this.phoneNo,
        this.dob,
        this.isActive,
        this.created,
        this.modified,
        this.accessToken,
    });

    final int id;
    final int roleId;
    final String firstName;
    final String lastName;
    final String email;
    final String username;
    final dynamic profilePic;
    final dynamic countryId;
    final String gender;
    final String phoneNo;
    final dynamic dob;
    final bool isActive;
    final String created;
    final String modified;
    final String accessToken;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"] == null ? null : json["id"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
        profilePic: json["profile_pic"],
        countryId: json["country_id"],
        gender: json["gender"] == null ? null : json["gender"],
        phoneNo: json["phone_no"] == null ? null : json["phone_no"],
        dob: json["dob"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        created: json["created"] == null ? null : json["created"],
        modified: json["modified"] == null ? null : json["modified"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "role_id": roleId == null ? null : roleId,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "username": username == null ? null : username,
        "profile_pic": profilePic,
        "country_id": countryId,
        "gender": gender == null ? null : gender,
        "phone_no": phoneNo == null ? null : phoneNo,
        "dob": dob,
        "is_active": isActive == null ? null : isActive,
        "created": created == null ? null : created,
        "modified": modified == null ? null : modified,
        "access_token": accessToken == null ? null : accessToken,
    };
}
