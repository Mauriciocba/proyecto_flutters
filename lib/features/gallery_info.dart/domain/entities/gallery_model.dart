import 'dart:convert';

List<GalleryModel> galleryInfoFromMap(String str) =>
    List<GalleryModel>.from(json.decode(str).map((x) => GalleryModel.fromMap(x)));

String galleryInfoToMap(List<GalleryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class GalleryModel {
  final int galId;
  final String galImage;
  final int eveId;

  GalleryModel({
    required this.galId,
    required this.galImage,
    required this.eveId,
  });

  factory GalleryModel.fromJson(String str) =>
      GalleryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GalleryModel.fromMap(Map<String, dynamic> json) => GalleryModel(
        galId: json["gal_id"],
        galImage: json["gal_image"],
        eveId: json["eve_id"],
      );

  Map<String, dynamic> toMap() => {
        "gal_id": galId,
        "gal_image": galImage,
        "eve_id": eveId,
      };
}
