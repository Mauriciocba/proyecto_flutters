import 'package:pamphlets_management/features/activity_categories/domain/entities/subcategory.dart';

final class Category {
  final int categoryId;
  String name;
  String? color;
  String? iconName;
  String? description;
  bool isActive;
  SubCategory? subCategory;

  Category({
    required this.categoryId,
    required this.name,
    this.color,
    this.iconName,
    this.description,
    this.isActive = true,
    this.subCategory,
  });
}
