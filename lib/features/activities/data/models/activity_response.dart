import 'dart:convert';

import 'package:pamphlets_management/features/activities/data/models/category_response.dart';
import 'package:pamphlets_management/features/activities/data/models/subcategory_response.dart';

List<ActivityResponse> activityResponseFromJson(String str) =>
    List<ActivityResponse>.from(
        json.decode(str).map((x) => ActivityResponse.fromJson(x)));

class ActivityResponse {
  int actId;
  String actName;
  String? actDescription;
  String? actLocation;
  DateTime actStart;
  DateTime actEnd;
  String? actForm;
  bool actAsk;
  List<SpeakerResponse>? speaker;
  List<CategoryElementResponse>? category;

  ActivityResponse({
    required this.actId,
    required this.actName,
    this.actDescription,
    required this.actLocation,
    required this.actStart,
    required this.actEnd,
    required this.actAsk,
    this.actForm,
    this.speaker,
    this.category,
  });

  factory ActivityResponse.fromJson(Map<String, dynamic> json) =>
      ActivityResponse(
        actId: json["act_id"],
        actName: json["act_name"],
        actDescription: json["act_description"],
        actLocation: json["act_location"],
        actForm: json["act_form"],
        actAsk: json["act_ask"],
        actStart: DateTime.parse(json["act_start"]),
        actEnd: DateTime.parse(json["act_end"]),
        speaker: json["speaker"] != null
            ? List<SpeakerResponse>.from(
                json["speaker"].map((x) => SpeakerResponse.fromJson(x)))
            : [],
        category: json["category"] != null
            ? List<CategoryElementResponse>.from(json["category"]
                .map((x) => CategoryElementResponse.fromJson(x)))
            : [],
      );
}

class SpeakerResponse {
  String speFirstName;
  String speLastName;

  SpeakerResponse({
    required this.speFirstName,
    required this.speLastName,
  });

  factory SpeakerResponse.fromJson(Map<String, dynamic> json) =>
      SpeakerResponse(
        speFirstName: json["spe_first_name"],
        speLastName: json["spe_last_name"],
      );

  Map<String, dynamic> toJson() => {
        "spe_first_name": speFirstName,
        "spe_last_name": speLastName,
      };
}

class CategoryElementResponse {
  final CategoryResponse? category;
  final SubcategoryResponse? subcategory;

  CategoryElementResponse({
    this.category,
    this.subcategory,
  });

  factory CategoryElementResponse.fromJson(Map<String, dynamic> json) =>
      CategoryElementResponse(
        category: json["category"] == null
            ? null
            : CategoryResponse.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : SubcategoryResponse.fromJson(json["subcategory"]),
      );

  Map<String, dynamic> toJson() => {
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
      };
}
