import 'dart:convert';

class GalleryCreateModel {
  final String galImage;
  final int eveId;

  GalleryCreateModel({
    required this.galImage,
    required this.eveId,
  });

  factory GalleryCreateModel.fromJson(String str) =>
      GalleryCreateModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GalleryCreateModel.fromMap(Map<String, dynamic> json) =>
      GalleryCreateModel(
        galImage: json["gal_image"],
        eveId: json["eve_id"],
      );

  Map<String, dynamic> toMap() => {
        "gal_image": galImage,
        "eve_id": eveId,
      };
}
