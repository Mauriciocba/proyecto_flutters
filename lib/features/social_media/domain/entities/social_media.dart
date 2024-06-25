// To parse this JSON data, do
//
//     final socialMedia = socialMediaFromJson(jsonString);

import 'dart:convert';

SocialMediaModel socialMediaFromJson(String str) =>
    SocialMediaModel.fromJson(json.decode(str));

String socialMediaToJson(SocialMediaModel data) => json.encode(data.toJson());

class SocialMediaModel {
  String? somName;
  String? somUrl;

  SocialMediaModel({
    this.somName,
    this.somUrl,
  });

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) =>
      SocialMediaModel(
        somName: json["som_name"],
        somUrl: json["som_url"],
      );

  Map<String, dynamic> toJson() => {
        "som_name": somName,
        "som_url": somUrl,
      };
}
