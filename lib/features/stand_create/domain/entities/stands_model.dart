import 'dart:convert';

class StandsModel {
    final int eveId;
    final String stdName;
    final String stdNameCompany;
    final String stdDescription;
    final int stdNumber;
    final String stdReferent;
    final String stdLogo;
    final bool stdStartup;

    StandsModel({
        required this.eveId,
        required this.stdName,
        required this.stdNameCompany,
        required this.stdDescription,
        required this.stdNumber,
        required this.stdReferent,
        required this.stdLogo,
        required this.stdStartup,
    });

    factory StandsModel.fromJson(String str) => StandsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory StandsModel.fromMap(Map<String, dynamic> json) => StandsModel(
        eveId: json["eve_id"],
        stdName: json["std_name"],
        stdNameCompany: json["std_name_company"],
        stdDescription: json["std_description"],
        stdNumber: json["std_number"],
        stdReferent: json["std_referent"],
        stdLogo: json["std_logo"],
        stdStartup: json["std_startup"],
    );

    Map<String, dynamic> toMap() => {
        "eve_id": eveId,
        "std_name": stdName,
        "std_name_company": stdNameCompany,
        "std_description": stdDescription,
        "std_number": stdNumber,
        "std_referent": stdReferent,
        "std_logo": stdLogo,
        "std_startup": stdStartup,
    };
}
