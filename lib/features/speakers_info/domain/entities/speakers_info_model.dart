import 'dart:convert';

List<SpeakersModel> speakersModelFromJson(String str) =>
    List<SpeakersModel>.from(
        json.decode(str).map((x) => SpeakersModel.fromJson(x)));

String speakersModelToJson(List<SpeakersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpeakersModel {
  int speId;
  String firstName;
  String lastName;
  String description;
  String photo;
  List<ActivitySpeaker>? activitySpeaker;
  List<SocialMedia> socialMedia;

  SpeakersModel({
    required this.speId,
    required this.firstName,
    required this.lastName,
    required this.description,
    required this.photo,
    this.activitySpeaker,
    required this.socialMedia,
  });

  factory SpeakersModel.fromMap(Map<String, dynamic> json) => SpeakersModel(
        speId: json["spe_id"],
        firstName: json["spe_first_name"],
        lastName: json["spe_last_name"],
        description: json["spe_description"],
        photo: json["spe_photo"],
        activitySpeaker: (json["activitySpeaker"] as List<dynamic>?)
            ?.map((x) => ActivitySpeaker.fromJson(x))
            .toList(),
        //List<ActivitySpeaker>.from(json["activitySpeaker"].map((x) => ActivitySpeaker.fromJson(x))),
        socialMedia: List<SocialMedia>.from(
            json["social_media"].map((x) => SocialMedia.fromJson(x))),
      );

  factory SpeakersModel.fromJson(Map<String, dynamic> json) => SpeakersModel(
        speId: json["spe_id"],
        firstName: json["spe_first_name"],
        lastName: json["spe_last_name"],
        description: json["spe_description"],
        photo: json["spe_photo"],
        activitySpeaker: (json["activitySpeaker"] as List<dynamic>?)
            ?.map((x) => ActivitySpeaker.fromJson(x))
            .toList(),
        //List<ActivitySpeaker>.from(json["activitySpeaker"].map((x) => ActivitySpeaker.fromJson(x))),
        socialMedia: List<SocialMedia>.from(
            json["social_media"].map((x) => SocialMedia.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "spe_id": speId,
        "spe_first_name": firstName,
        "spe_last_name": lastName,
        "spe_description": description,
        "photo": photo,
        "activitySpeaker": activitySpeaker != null
            ? List<dynamic>.from(activitySpeaker!.map((x) => x.toJson()))
            : null,
        "social_media": List<dynamic>.from(socialMedia.map((x) => x.toJson())),
      };
}

class ActivitySpeaker {
  int actId;
  ActId? activitySpeakerActId;

  ActivitySpeaker({
    required this.actId,
    required this.activitySpeakerActId,
  });

  factory ActivitySpeaker.fromJson(Map<String, dynamic> json) =>
      ActivitySpeaker(
        actId: json["actId"],
        activitySpeakerActId:
            json["act_id"] != null ? ActId.fromJson(json["act_id"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "actId": actId,
        "act_id": activitySpeakerActId?.toJson(),
      };
}

class ActId {
  String actLocation;

  ActId({
    required this.actLocation,
  });

  factory ActId.fromJson(Map<String, dynamic> json) => ActId(
        actLocation: json["act_location"],
      );

  Map<String, dynamic> toJson() => {
        "act_location": actLocation,
      };
}

class SocialMedia {
  String somName;
  String somUrl;

  SocialMedia({
    required this.somUrl,
    required this.somName,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        somUrl: json["som_url"],
        somName: json["som_name"],
      );

  Map<String, dynamic> toJson() => {
        "som_url": somUrl,
        "som_name": somName,
      };
}
