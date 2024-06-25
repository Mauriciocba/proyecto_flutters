class SubcategoryResponse {
  final int ascId;
  final String? ascFontColor;
  final String ascBlock;
  final String? ascIcon;
  final String ascDescription;
  final bool? ascIsActive;

  SubcategoryResponse({
    required this.ascId,
    this.ascFontColor,
    required this.ascBlock,
    this.ascIcon,
    required this.ascDescription,
    this.ascIsActive,
  });

  factory SubcategoryResponse.fromJson(Map<String, dynamic> json) =>
      SubcategoryResponse(
        ascId: json["asc_id"],
        ascFontColor: json["asc_font_color"],
        ascBlock: json["asc_block"],
        ascIcon: json["asc_icon"],
        ascDescription: json["asc_description"],
        ascIsActive: json["asc_is_active"],
      );

  Map<String, dynamic> toJson() => {
        "asc_id": ascId,
        "asc_font_color": ascFontColor,
        "asc_block": ascBlock,
        "asc_icon": ascIcon,
        "asc_description": ascDescription,
        "asc_is_active": ascIsActive,
      };
}
