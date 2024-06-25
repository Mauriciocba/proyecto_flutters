import 'dart:convert';

List<Event> eventFromMap(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromMap(x)));

String eventToMap(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Event {
  final int eveId;
  final String eveName;
  final String eveDescription;
  final String? eveLogo;
  final String? eveUrl;
  final String? eveIcon;
  final String? eveAddress;
  final String? eveUrlMap;
  final DateTime eveStart;
  final DateTime eveEnd;
  final String? evePhoto;
  final String? eveSubtitle;
  final String? eveAdditionalInfo;
  final bool? eveNetworking;
  final bool? eveTicket;

  Event({
    required this.eveId,
    required this.eveName,
    required this.eveDescription,
    this.eveLogo,
    this.eveUrl,
    this.eveIcon,
    this.eveAddress,
    this.eveUrlMap,
    required this.eveStart,
    required this.eveEnd,
    this.evePhoto,
    this.eveSubtitle,
    this.eveAdditionalInfo,
    this.eveNetworking,
    this.eveTicket,
  });

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        eveId: json["eve_id"],
        eveName: json["eve_name"],
        eveDescription: json["eve_description"],
        eveLogo: json["eve_logo"],
        eveUrl: json["eve_url"],
        eveIcon: json["eve_icon"],
        eveAddress: json["eve_address"],
        eveUrlMap: json["eve_url_map"],
        eveStart: DateTime.parse(json["eve_start"]),
        eveEnd: DateTime.parse(json["eve_end"]),
        evePhoto: json["eve_photo"],
        eveSubtitle: json["eve_subtitle"],
        eveAdditionalInfo: json["eve_additional_info"],
        eveTicket: json["eve_ticket"],
        eveNetworking: json["eve_networking"],
      );

  Map<String, dynamic> toMap() => {
        "eve_id": eveId,
        "eve_name": eveName,
        "eve_description": eveDescription,
        "eve_logo": eveLogo,
        "eve_url": eveUrl,
        "eve_icon": eveIcon,
        "eve_address": eveAddress,
        "eve_url_map": eveUrlMap,
        "eve_start": eveStart.toIso8601String(),
        "eve_end": eveEnd.toIso8601String(),
        "eve_photo": evePhoto,
        "eve_subtitle": eveSubtitle,
        "eve_additional_info": eveAdditionalInfo,
        "eve_ticket": eveTicket,
        "eve_networking": eveNetworking,
      };
}
