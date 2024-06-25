import 'dart:convert';

List<ActivityMetricResponse> activityMetricResponseFromJson(String str) =>
    List<ActivityMetricResponse>.from(
        json.decode(str).map((x) => ActivityMetricResponse.fromJson(x)));

String activityMetricResponseToJson(List<ActivityMetricResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActivityMetricResponse {
  final int actId;
  final String actName;
  final String activityLogs;

  ActivityMetricResponse({
    required this.actId,
    required this.actName,
    required this.activityLogs,
  });

  factory ActivityMetricResponse.fromJson(String str) =>
      ActivityMetricResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ActivityMetricResponse.fromMap(Map<String, dynamic> json) =>
      ActivityMetricResponse(
        actId: json["act_id"],
        actName: json["act_name"],
        activityLogs: json["registros_actividad"],
      );

  Map<String, dynamic> toMap() => {
        "act_id": actId,
        "act_name": actName,
        "registros_actividad": activityLogs,
      };
}