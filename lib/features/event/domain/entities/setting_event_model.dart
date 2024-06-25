import 'dart:convert';

class SettingEventModel {
  final String? estPrimaryColorDark;
  final String? estSecondary1ColorDark;
  final String? estSecondary2ColorDark;
  final String? estSecondary3ColorDark;
  final String? estAccentColorDark;
  final String? estPrimaryColorLight;
  final String? estSecondary1ColorLight;
  final String? estSecondary2ColorLight;
  final String? estSecondary3ColorLight;
  final String? estAccentColorLight;
  final String? estLanguage;
  final String? estFont;
  final String? estTimeZone;
  int? eveId;

  SettingEventModel({
    this.estPrimaryColorDark,
    this.estSecondary1ColorDark,
    this.estSecondary2ColorDark,
    this.estSecondary3ColorDark,
    this.estAccentColorDark,
    this.estPrimaryColorLight,
    this.estSecondary1ColorLight,
    this.estSecondary2ColorLight,
    this.estSecondary3ColorLight,
    this.estAccentColorLight,
    this.estLanguage,
    this.estFont,
    this.estTimeZone,
    this.eveId,
  });

  factory SettingEventModel.fromJson(String str) =>
      SettingEventModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SettingEventModel.fromMap(Map<String, dynamic> json) =>
      SettingEventModel(
        estPrimaryColorDark: json["est_primary_color_dark"],
        estSecondary1ColorDark: json["est_secondary_1_color_dark"],
        estSecondary2ColorDark: json["est_secondary_2_color_dark"],
        estSecondary3ColorDark: json["est_secondary_3_color_dark"],
        estAccentColorDark: json["est_accent_color_dark"],
        estPrimaryColorLight: json["est_primary_color_light"],
        estSecondary1ColorLight: json["est_secondary_1_color_light"],
        estSecondary2ColorLight: json["est_secondary_2_color_light"],
        estSecondary3ColorLight: json["est_secondary_3_color_light"],
        estAccentColorLight: json["est_accent_color_light"],
        estLanguage: json["est_language"],
        estFont: json["est_font"],
        estTimeZone: json["est_time_zone"],
        eveId: json["eve_id"],
      );

  Map<String, dynamic> toMap() => {
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
