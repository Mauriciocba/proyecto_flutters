import 'dart:convert';

class SponsorsCreateModel {
    final int eveId;
    final int? spcId;
    final String spoName;
    final String spoDescription;
    final String spoLogo;
    final String? spoUrl;

    SponsorsCreateModel({
        required this.eveId,
        this.spcId,
        required this.spoName,
        required this.spoDescription,
        required this.spoLogo,
        this.spoUrl,
    });

    factory SponsorsCreateModel.fromJson(String str) => SponsorsCreateModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SponsorsCreateModel.fromMap(Map<String, dynamic> json) => SponsorsCreateModel(
        eveId: json["eve_id"],
        spcId: json["spc_id"],
        spoName: json["spo_name"],
        spoDescription: json["spo_description"],
        spoLogo: json["spo_logo"],
        spoUrl: json["spo_url"],
    );

    Map<String, dynamic> toMap() => {
        "eve_id": eveId,
        "spc_id": spcId,
        "spo_name": spoName,
        "spo_description": spoDescription,
        "spo_logo": spoLogo,
        "spo_url": spoUrl,
    };
}
