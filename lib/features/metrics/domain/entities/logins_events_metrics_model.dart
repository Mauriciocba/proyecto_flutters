import 'dart:convert';

class LoginsEventsMetricsModel {
  final Logins logins;

  LoginsEventsMetricsModel({
    required this.logins,
  });

  factory LoginsEventsMetricsModel.fromJson(String str) =>
      LoginsEventsMetricsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginsEventsMetricsModel.fromMap(Map<String, dynamic> json) =>
      LoginsEventsMetricsModel(
        logins: Logins.fromMap(json["logins"]),
      );

  Map<String, dynamic> toMap() => {
        "logins": logins.toMap(),
      };
}

class Logins {
  final String eveName;
  final DateTime eveEnd;
  final int eveId;
  final String loginsPerEvent;

  Logins({
    required this.eveName,
    required this.eveEnd,
    required this.eveId,
    required this.loginsPerEvent,
  });

  factory Logins.fromJson(String str) => Logins.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Logins.fromMap(Map<String, dynamic> json) => Logins(
        eveName: json["eve_name"],
        eveEnd: DateTime.parse(json["eve_end"]),
        eveId: json["eve_id"],
        loginsPerEvent: json["logins_per_event"],
      );

  Map<String, dynamic> toMap() => {
        "eve_name": eveName,
        "eve_end": eveEnd.toIso8601String(),
        "eve_id": eveId,
        "logins_per_event": loginsPerEvent,
      };
}
