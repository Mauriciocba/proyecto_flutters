import 'dart:convert';

List<SponsorsCategoryResponse> sponsorsCategoryResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return List<SponsorsCategoryResponse>.from(jsonData.map((x) => SponsorsCategoryResponse.fromMap(x)));
}

List<SponsorsCategoryResponse> SponsorsCFromMap(String str) =>
    List<SponsorsCategoryResponse>.from(
        json.decode(str).map((x) { 
          return SponsorsCategoryResponse.fromMap(x);})).toList();

class SponsorsCategoryResponse {
  final int spcId;
  final String spcName;
  final String spcDescription;
  final Map<String, dynamic> eveId;

  SponsorsCategoryResponse({
    required this.spcId,
    required this.spcName,
    required this.spcDescription,
    required this.eveId,
  });

  factory SponsorsCategoryResponse.fromJson(String str) =>
      SponsorsCategoryResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SponsorsCategoryResponse.fromMap(Map<String, dynamic> json) =>
      SponsorsCategoryResponse(
        spcId: json["spc_id"],
        spcName: json["spc_name"],
        spcDescription: json["spc_description"],
        eveId: json["eve_id"],
      );

  Map<String, dynamic> toMap() => {
        "spc_id": spcId,
        "spc_name": spcName,
        "spc_description": spcDescription,
        "eve_id": eveId,
      };
}
