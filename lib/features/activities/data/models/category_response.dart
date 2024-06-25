class CategoryResponse {
  final int accId;
  final String? accFontColor;
  final String accBlock;
  final String? accIcon;
  final String accDescription;
  final bool? accIsActive;
  final int? ascId;

  CategoryResponse({
    required this.accId,
    this.accFontColor,
    required this.accBlock,
    this.accIcon,
    required this.accDescription,
    this.accIsActive,
    required this.ascId,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        accId: json["acc_id"],
        accFontColor: json["acc_font_color"],
        accBlock: json["acc_block"],
        accIcon: json["acc_icon"],
        accDescription: json["acc_description"],
        accIsActive: json["acc_is_active"],
        ascId: json["asc_id"],
      );

  Map<String, dynamic> toJson() => {
        "acc_id": accId,
        "acc_font_color": accFontColor,
        "acc_block": accBlock,
        "acc_icon": accIcon,
        "acc_description": accDescription,
        "acc_is_active": accIsActive,
        "asc_id": ascId,
      };
}
