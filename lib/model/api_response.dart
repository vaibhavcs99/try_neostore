// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
    ApiResponse({
        this.status,
        this.data,
        this.message,
        this.userMsg,
    });

    final int status;
    final Data data;
    final String message;
    final String userMsg;

    factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
        userMsg: json["user_msg"] == null ? null : json["user_msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
        "user_msg": userMsg == null ? null : userMsg,
    };
}

class Data {
    Data({
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
    final String profilePic;
    final dynamic countryId;
    final String gender;
    final String phoneNo;
    final String dob;
    final bool isActive;
    final String created;
    final String modified;
    final String accessToken;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        "dob": dob==null?'null':dob,
        "is_active": isActive == null ? null : isActive,
        "created": created == null ? null : created,
        "modified": modified == null ? null : modified,
        "access_token": accessToken == null ? null : accessToken,
    };
}
