import 'dart:convert';

List<SponsorsInfoModel> sponsorsInfoFromMap(String str) =>
    List<SponsorsInfoModel>.from(
        json.decode(str).map((x) => SponsorsInfoModel.fromMap(x)));

class SponsorsInfoModel {
    final List<Sponsor> sponsors;

    SponsorsInfoModel({
        required this.sponsors,
    });

    factory SponsorsInfoModel.fromJson(String str) => SponsorsInfoModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SponsorsInfoModel.fromMap(Map<String, dynamic> json) => SponsorsInfoModel(
        sponsors: List<Sponsor>.from(json["sponsors"].map((x) => Sponsor.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "sponsors": List<dynamic>.from(sponsors.map((x) => x.toMap())),
    };
}

class Sponsor {
    final int spoId;
    final String spoName;
    final String spoLogo;
    final String? spoUrl;
    final String spoDescription;
    final String? spcName;
    final int? spcId;

    Sponsor({
        required this.spoId,
        required this.spoName,
        required this.spoLogo,
        this.spoUrl,
        required this.spoDescription,
        this.spcName,
        this.spcId
    });

    factory Sponsor.fromJson(String str) => Sponsor.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Sponsor.fromMap(Map<String, dynamic> json) => Sponsor(
        spoId: json["spo_id"],
        spoName: json["spo_name"],
        spoLogo: json["spo_logo"],
        spoUrl: json["spo_url"],
        spoDescription: json["spo_description"],
        spcName: json["spc_name"],
        spcId: json["spc_id"],
    );

    Map<String, dynamic> toMap() => {
        "spo_id": spoId,
        "spo_name": spoName,
        "spo_logo": spoLogo,
        "spo_url": spoUrl,
        "spo_description": spoDescription,
        "spc_name": spcName,
        "spc_id": spcId
    };
}
