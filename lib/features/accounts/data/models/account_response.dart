import 'dart:convert';

List<AccountResponse> accountResponseFromJson(String str) =>
    List<AccountResponse>.from(
        json.decode(str).map((x) => AccountResponse.fromJson(x)));

String accountResponseToJson(List<AccountResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountResponse {
  final int usrId;
  final String email;
  final String? name;
  final String? company;
  final String? rol;
  final String? photo;

  const AccountResponse({
    required this.usrId,
    required this.email,
    required this.name,
    required this.company,
    required this.rol,
    required this.photo,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      AccountResponse(
        usrId: json["usr_id"],
        email: json['email'],
        name: json["name"],
        company: json["company"],
        rol: json["rol"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "usr_id": usrId,
        "email": email,
        "name": name,
        "company": company,
        "rol": rol,
        "photo": photo,
      };
}
