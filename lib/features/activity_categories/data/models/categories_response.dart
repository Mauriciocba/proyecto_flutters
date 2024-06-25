// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromJson(jsonString);

import 'dart:convert';

List<CategoriesResponse> categoriesResponseFromJson(String str) =>
    List<CategoriesResponse>.from(
        json.decode(str).map((x) => CategoriesResponse.fromJson(x)));

String categoriesResponseToJson(List<CategoriesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesResponse {
  final int accId;
  final String? accFontColor;
  final String? accBlock;
  final String? accIcon;
  final String? accDescription;
  final dynamic accIsActive;
  final dynamic ascId;
  final dynamic subcategory;

  CategoriesResponse({
    required this.accId,
    required this.accFontColor,
    required this.accBlock,
    required this.accIcon,
    required this.accDescription,
    required this.accIsActive,
    required this.ascId,
    required this.subcategory,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        accId: json["acc_id"],
        accFontColor: json["acc_font_color"],
        accBlock: json["acc_block"],
        accIcon: json["acc_icon"],
        accDescription: json["acc_description"],
        accIsActive: json["acc_is_active"],
        ascId: json["asc_id"],
        subcategory: json["subcategory"],
      );

  Map<String, dynamic> toJson() => {
        "acc_id": accId,
        "acc_font_color": accFontColor,
        "acc_block": accBlock,
        "acc_icon": accIcon,
        "acc_description": accDescription,
        "acc_is_active": accIsActive,
        "asc_id": ascId,
        "subcategory": subcategory,
      };
}
