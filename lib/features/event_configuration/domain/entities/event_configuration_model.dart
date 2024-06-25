import 'dart:convert';

List<EventConfigurationModel> eventConfigurationFromMap(String str) =>
    List<EventConfigurationModel>.from(
        json.decode(str).map((x) => EventConfigurationModel.fromMap(x)));

class EventConfigurationModel {
  final int estId;
  final String estPrimaryColorDark;
  final String estSecondary1ColorDark;
  final String estSecondary2ColorDark;
  final String estSecondary3ColorDark;
  final String estAccentColorDark;
  final String estPrimaryColorLight;
  final String estSecondary1ColorLight;
  final String estSecondary2ColorLight;
  final String estSecondary3ColorLight;
  final String estAccentColorLight;
  final String estLanguage;
  final String estFont;
  final String estTimeZone;
  final int eveId;

  EventConfigurationModel({
    required this.estId,
    required this.estPrimaryColorDark,
    required this.estSecondary1ColorDark,
    required this.estSecondary2ColorDark,
    required this.estSecondary3ColorDark,
    required this.estAccentColorDark,
    required this.estPrimaryColorLight,
    required this.estSecondary1ColorLight,
    required this.estSecondary2ColorLight,
    required this.estSecondary3ColorLight,
    required this.estAccentColorLight,
    required this.estLanguage,
    required this.estFont,
    required this.estTimeZone,
    required this.eveId,
  });

  factory EventConfigurationModel.fromJson(String str) =>
      EventConfigurationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventConfigurationModel.fromMap(Map<String, dynamic> json) =>
      EventConfigurationModel(
        estId: json["est_id"],
        estPrimaryColorDark:
            json["est_primary_color_dark"] ?? "No tiene configurado un Color.",
        estSecondary1ColorDark: json["est_secondary_1_color_dark"] ??
            "No tiene configurado un Color.",
        estSecondary2ColorDark: json["est_secondary_2_color_dark"] ??
            "No tiene configurado un Color.",
        estSecondary3ColorDark: json["est_secondary_3_color_dark"] ??
            "No tiene configurado un Color.",
        estAccentColorDark:
            json["est_accent_color_dark"] ?? "No tiene configurado un Color.",
        estPrimaryColorLight:
            json["est_primary_color_light"] ?? "No tiene configurado un Color.",
        estSecondary1ColorLight: json["est_secondary_1_color_light"] ??
            "No tiene configurado un Color.",
        estSecondary2ColorLight: json["est_secondary_2_color_light"] ??
            "No tiene configurado un Color.",
        estSecondary3ColorLight: json["est_secondary_3_color_light"] ??
            "No tiene configurado un Color.",
        estAccentColorLight:
            json["est_accent_color_light"] ?? "No tiene configurado un Color.",
        estLanguage: json["est_language"] ?? "No Tiene configurado un Lenguaje",
        estFont: json["est_font"] ?? "Roboto",
        estTimeZone: json["est_time_zone"],
        eveId: json["eve_id"],
      );

  Map<String, dynamic> toMap() => {
        "est_id": estId,
        "est_primary_color_dark": estPrimaryColorDark,
        "est_secondary_1_color_dark": estSecondary1ColorDark,
        "est_secondary_2_color_dark": estSecondary2ColorDark,
        "est_secondary_3_color_dark": estSecondary3ColorDark,
        "est_accent_color_dark": estAccentColorDark,
        "est_primary_color_light": estPrimaryColorLight,
        "est_secondary_1_color_light": estSecondary1ColorLight,
        "est_secondary_2_color_light": estSecondary2ColorLight,
        "est_secondary_3_color_light": estSecondary3ColorLight,
        "est_accent_color_light": estAccentColorLight,
        "est_language": estLanguage,
        "est_font": estFont,
        "est_time_zone": estTimeZone,
        "eve_id": eveId,
      };
}
