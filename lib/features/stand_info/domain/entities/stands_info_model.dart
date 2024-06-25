import 'dart:convert';

List<StandsInfoModel> standsInfoFromMap(String str) =>
    List<StandsInfoModel>.from(
        json.decode(str).map((x) => StandsInfoModel.fromMap(x)));

class StandsInfoModel {
  final int stdId;
  final String stdName;
  final String stdNameCompany;
  final String stdDescription;
  final int stdNumber;
  final String stdReferent;
  final bool stdStartup;
  final String stdLogo;
  final List<Web> web;

  StandsInfoModel({
    required this.stdId,
    required this.stdName,
    required this.stdNameCompany,
    required this.stdDescription,
    required this.stdNumber,
    required this.stdReferent,
    required this.stdStartup,
    required this.stdLogo,
    required this.web,
  });

  factory StandsInfoModel.fromJson(String str) =>
      StandsInfoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StandsInfoModel.fromMap(Map<String, dynamic> json) => StandsInfoModel(
        stdId: json["std_id"],
        stdName: json["std_name"],
        stdNameCompany: json["std_name_company"],
        stdDescription: json["std_description"],
        stdNumber: json["std_number"],
        stdReferent: json["std_referent"],
        stdStartup: json["std_startup"],
        stdLogo: json["std_logo"],
        web: List<Web>.from(json["web"].map((x) => Web.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "std_id": stdId,
        "std_name": stdName,
        "std_name_company": stdNameCompany,
        "std_description": stdDescription,
        "std_number": stdNumber,
        "std_referent": stdReferent,
        "std_startup": stdStartup,
        "std_logo": stdLogo,
        "web": List<dynamic>.from(web.map((x) => x.toMap())),
      };
}

class Web {
  final String? somName;
  final String asUrl;
  final String? asName;

  Web({
    this.somName,
    required this.asUrl,
    this.asName,
  });

  factory Web.fromJson(String str) => Web.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Web.fromMap(Map<String, dynamic> json) => Web(
        somName: json["som_name"],
        asUrl: json["as_url"],
        asName: json["as_name"],
      );

  Map<String, dynamic> toMap() => {
        "som_name": somName,
        "as_url": asUrl,
        "as_name": asName,
      };
}
