import 'dart:convert';

class CreateEventModel {
  final String eveName;
  final String eveDescription;
  final DateTime eveStart;
  final DateTime eveEnd;
  final bool eveTicket;
  final bool eveNetworking;
  final String? eveLogo;
  final String? eveIcon;
  final String? evePhoto;
  final String? eveSubtitle;
  final String? eveAdditionalInfo;
  final String? siteWeb;
  final String? eveAddress;
  final String? eveUrlMap;
  final String? eveLatitude;
  final String? eveLongitude;

  CreateEventModel(
      {required this.eveName,
      required this.eveDescription,
      required this.eveStart,
      required this.eveEnd,
      required this.eveTicket,
      required this.eveNetworking,
      this.eveLogo,
      this.eveIcon,
      this.evePhoto,
      this.eveSubtitle,
      this.eveAdditionalInfo,
      this.siteWeb,
      this.eveAddress,
      this.eveUrlMap,
      this.eveLatitude,
      this.eveLongitude});

  factory CreateEventModel.fromJson(String str) =>
      CreateEventModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateEventModel.fromMap(Map<String, dynamic> json) =>
      CreateEventModel(
        eveName: json["eve_name"],
        eveDescription: json["eve_description"],
        eveStart: DateTime.parse(json["eve_start"]),
        eveEnd: DateTime.parse(json["eve_end"]),
        eveTicket: json["eve_ticket"],
        eveNetworking: json["eve_networking"],
        eveLogo: json["eve_logo"],
        eveIcon: json["eve_icon"],
        evePhoto: json["eve_photo"],
        eveSubtitle: json["eve_subtitle"],
        eveAdditionalInfo: json["eve_additional_info"],
        siteWeb: json["eve_url"],
        eveAddress: json["eve_address"],
        eveUrlMap: json["eve_url_map"],
        eveLongitude: json["eve_longitude"],
        eveLatitude: json["eve_latitude"],
      );

  Map<String, dynamic> toMap() => {
        "eve_name": eveName,
        "eve_description": eveDescription,
        "eve_start": eveStart.toIso8601String(),
        "eve_end": eveEnd.toIso8601String(),
        "eve_ticket": eveTicket,
        "eve_networking": eveNetworking,
        "eve_logo": eveLogo,
        "eve_icon": eveIcon,
        "eve_photo": evePhoto,
        "eve_subtitle": eveSubtitle,
        "eve_additional_info": eveAdditionalInfo,
        "eve_url": siteWeb,
        "eve_address": eveAddress,
        "eve_url_map": eveUrlMap,
        "eve_longitude": eveLongitude,
        "eve_latitude": eveLatitude,
      };
}
