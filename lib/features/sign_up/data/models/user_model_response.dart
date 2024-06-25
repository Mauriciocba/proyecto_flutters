// To parse this JSON data, do
//
//     final userModelResponse = userModelResponseFromJson(jsonString);

import 'dart:convert';

UserModelResponse userModelResponseFromJson(String str) =>
    UserModelResponse.fromJson(json.decode(str));

String userModelResponseToJson(UserModelResponse data) =>
    json.encode(data.toJson());

class UserModelResponse {
  final String message;
  final int statusCode;
  final Data data;

  UserModelResponse({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory UserModelResponse.fromJson(Map<String, dynamic> json) =>
      UserModelResponse(
        message: json["message"],
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "data": data.toJson(),
      };
}

class Data {
  final int id;
  final String email;
  final String password;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CorId corId;

  Data({
    required this.id,
    required this.email,
    required this.password,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.corId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        corId: CorId.fromJson(json["cor_id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "isActive": isActive,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "cor_id": corId.toJson(),
      };
}

class CorId {
  final int corId;
  final String corName;
  final String corDescription;

  CorId({
    required this.corId,
    required this.corName,
    required this.corDescription,
  });

  factory CorId.fromJson(Map<String, dynamic> json) => CorId(
        corId: json["cor_id"],
        corName: json["cor_name"],
        corDescription: json["cor_description"],
      );

  Map<String, dynamic> toJson() => {
        "cor_id": corId,
        "cor_name": corName,
        "cor_description": corDescription,
      };
}
