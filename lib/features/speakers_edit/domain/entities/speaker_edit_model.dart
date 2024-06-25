// To parse this JSON data, do
//
//     final speakers = speakersFromJson(jsonString);

import 'dart:convert';

List<SpeakerEditModel> speakersFromJson(String str) => List<SpeakerEditModel>.from(json.decode(str).map((x) => SpeakerEditModel.fromJson(x)));

String speakersToJson(List<SpeakerEditModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpeakerEditModel {
    int speId;
    int eveId;
    String speFirstName;
    String speLastName;
    String speDescription;
    String spePhoto;

    SpeakerEditModel({
        required this.speId,
        required this.eveId,
        required this.speFirstName,
        required this.speLastName,
        required this.speDescription,
        required this.spePhoto,
    });

    factory SpeakerEditModel.fromJson(Map<String, dynamic> json) => SpeakerEditModel(
        speId: json["spe_id"],
        eveId: json["eve_id"],
        speFirstName: json["spe_first_name"],
        speLastName: json["spe_last_name"],
        speDescription: json["spe_description"],
        spePhoto: json["spe_photo"],
    );

    Map<String, dynamic> toJson() => {
        "spe_id": speId,
        "eve_id": eveId,
        "spe_first_name": speFirstName,
        "spe_last_name": speLastName,
        "spe_description": speDescription,
        "spe_photo": spePhoto,
    };
}
