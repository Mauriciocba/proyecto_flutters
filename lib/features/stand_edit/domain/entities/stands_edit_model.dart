import 'dart:convert';

List<StandsEditModel> standsInfoFromMap(String str) =>
    List<StandsEditModel>.from(
        json.decode(str).map((x) => StandsEditModel.fromMap(x)));

class StandsEditModel {
  final int stdId;
  final String stdName;
  final String stdNameCompany;
  final String stdDescription;
  final int stdNumber;
  final String stdReferent;
  final bool stdStartup;
  final String stdLogo;

  StandsEditModel({
    required this.stdId,
    required this.stdName,
    required this.stdNameCompany,
    required this.stdDescription,
    required this.stdNumber,
    required this.stdReferent,
    required this.stdStartup,
    required this.stdLogo,
  });

  factory StandsEditModel.fromJson(String str) =>
      StandsEditModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StandsEditModel.fromMap(Map<String, dynamic> json) => StandsEditModel(
        stdId: json["std_id"],
        stdName: json["std_name"],
        stdNameCompany: json["std_name_company"],
        stdDescription: json["std_description"],
        stdNumber: json["std_number"],
        stdReferent: json["std_referent"],
        stdStartup: json["std_startup"],
        stdLogo: json["std_logo"],
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
      };
}
