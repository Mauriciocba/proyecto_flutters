final class SubCategory {
  final int subcategoryId;
  final String name;
  final String? color;
  final String? icon;
  final String? description;
  final bool isActive;

  SubCategory(
      {required this.subcategoryId,
      required this.name,
      required this.color,
      required this.icon,
      required this.description,
      required this.isActive});
}
