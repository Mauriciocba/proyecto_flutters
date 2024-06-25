// To parse this JSON data, do
//
//     final speakers = speakersFromJson(jsonString);

import 'dart:convert';

List<SpeakersModel> speakersFromJson(String str) => List<SpeakersModel>.from(json.decode(str).map((x) => SpeakersModel.fromJson(x)));

String speakersToJson(List<SpeakersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpeakersModel {
    int eveId;
    String speFirstName;
    String speLastName;
    String speDescription;
    String spePhoto;

    SpeakersModel({
        required this.eveId,
        required this.speFirstName,
        required this.speLastName,
        required this.speDescription,
        required this.spePhoto,
    });

    factory SpeakersModel.fromJson(Map<String, dynamic> json) => SpeakersModel(
        eveId: json["eve_id"],
        speFirstName: json["spe_first_name"],
        speLastName: json["spe_last_name"],
        speDescription: json["spe_description"],
        spePhoto: json["spe_photo"],
    );

    Map<String, dynamic> toJson() => {
        "eve_id": eveId,
        "spe_first_name": speFirstName,
        "spe_last_name": speLastName,
        "spe_description": speDescription,
        "spe_photo": spePhoto,
    };
}
