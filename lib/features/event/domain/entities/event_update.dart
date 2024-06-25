import 'dart:convert';

class EventUpdate {
  final String eveName;
  final String eveDescription;
  final String? eveLogo;
  final String? eveUrl;
  final String? eveIcon;
  final String? evePhoto;
  final String? eveSubtitle;
  final String? eveAdditionalInfo;
  final String? eveAddress;
  final String? eveUrlMap;
  final DateTime eveStart;
  final DateTime eveEnd;
  final bool? eveTicket;
  final bool? eveNetworking;

  EventUpdate({
    required this.eveName,
    required this.eveDescription,
    this.eveLogo,
    this.eveUrl,
    this.eveIcon,
    this.evePhoto,
    this.eveSubtitle,
    this.eveAdditionalInfo,
    this.eveAddress,
    required this.eveStart,
    required this.eveEnd,
    this.eveTicket,
    this.eveNetworking,
    this.eveUrlMap,
  });

  factory EventUpdate.fromJson(String str) =>
      EventUpdate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventUpdate.fromMap(Map<String, dynamic> json) => EventUpdate(
        eveName: json["eve_name"],
        eveDescription: json["eve_description"],
        eveLogo: json["eve_logo"],
        eveUrl: json["eve_url"],
        eveIcon: json["eve_icon"],
        evePhoto: json["eve_photo"],
        eveSubtitle: json["eve_subtitle"],
        eveAdditionalInfo: json["eve_additional_info"],
        eveAddress: json["eve_address"],
        eveUrlMap: json["eve_url_map"],
        eveStart: DateTime.parse(json["eve_start"]),
        eveEnd: DateTime.parse(json["eve_end"]),
        eveTicket: json["eve_ticket"],
        eveNetworking: json["eve_networking"],
      );

  Map<String, dynamic> toMap() => {
        "eve_name": eveName,
        "eve_description": eveDescription,
        "eve_logo": eveLogo,
        "eve_url": eveUrl,
        "eve_icon": eveIcon,
        "eve_photo": evePhoto,
        "eve_subtitle": eveSubtitle,
        "eve_additional_info": eveAdditionalInfo,
        "eve_address": eveAddress,
        "eve_url_map": eveUrlMap,
        "eve_start": eveStart.toIso8601String(),
        "eve_end": eveEnd.toIso8601String(),
        "eve_ticket": eveTicket,
        "eve_networking": eveNetworking,
      };
}
