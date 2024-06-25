import 'dart:convert';

class NewsModel {
    final String newArticle;
    final int eveId;
    final String? newUrl;
    final String? newImage;
    final DateTime? newCreatedAt;

    NewsModel({
        required this.newArticle,
        required this.eveId,
         this.newUrl,
         this.newImage,
         this.newCreatedAt,
    });

    factory NewsModel.fromJson(String str) => NewsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        newArticle: json["new_article"],
        eveId: json["eve_id"],
        newUrl: json["new_url"],
        newImage: json["new_image"],
        newCreatedAt: DateTime.parse(json["new_created_at"]),
    );

    Map<String, dynamic> toMap() => {
        "new_article": newArticle,
        "eve_id": eveId,
        "new_url": newUrl,
        "new_image": newImage,
        "new_created_at": newCreatedAt?.toIso8601String(),
    };
}
