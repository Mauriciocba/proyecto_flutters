import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

List<NewsModel> newsInfoFromMap(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromMap(x)));

String newsInfoToMap(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class NewsModel {
  final int newId;
  final String newArticle;
  final int eveId;
  //final bool newIsActive;
  final String? newUrl;
  final String? newImage;
  final DateTime? newCreatedAt;

  NewsModel({
    required this.newId,
    required this.newArticle,
    required this.eveId,
    //required this.newIsActive,
    required this.newUrl,
    required this.newImage,
    required this.newCreatedAt,
  });

  factory NewsModel.fromJson(String str) => NewsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        newId: json["new_id"],
        newArticle: json["new_article"],
        eveId: json["eve_id"],
        //newIsActive: json["new_is_active"],
        newUrl: json["new_url"],
        newImage: json["new_image"],
        newCreatedAt: DateTime.parse(json["new_created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "new_id": newId,
        "new_article": newArticle,
        "eve_id": eveId,
        //"new_is_active": newIsActive,
        "new_url": newUrl,
        "new_image": newImage,
        "new_created_at": newCreatedAt?.toIso8601String(),
      };
}
