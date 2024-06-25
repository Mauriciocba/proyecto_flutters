import 'dart:convert';

class LoginsHourMetricsModel {
  final int eventId;
  final String eveName;
  final List<Login> logins;

  LoginsHourMetricsModel({
    required this.eventId,
    required this.eveName,
    required this.logins,
  });

  factory LoginsHourMetricsModel.fromJson(String str) =>
      LoginsHourMetricsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginsHourMetricsModel.fromMap(Map<String, dynamic> json) =>
      LoginsHourMetricsModel(
        eventId: json["eventId"],
        eveName: json["eve_name"],
        logins: List<Login>.from(json["logins"].map((x) => Login.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "eventId": eventId,
        "eve_name": eveName,
        "logins": List<dynamic>.from(logins.map((x) => x.toMap())),
      };
}

class Login {
  final DateTime loginHour;
  final String loginsPerHour;

  Login({
    required this.loginHour,
    required this.loginsPerHour,
  });

  factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        loginHour: DateTime.parse(json["login_hour"]),
        loginsPerHour: json["logins_per_hour"],
      );

  Map<String, dynamic> toMap() => {
        "login_hour": loginHour.toIso8601String(),
        "logins_per_hour": loginsPerHour,
      };
}
