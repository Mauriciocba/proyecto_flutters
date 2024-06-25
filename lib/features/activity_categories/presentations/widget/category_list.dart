import 'package:flutter/material.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/widget/category_list_item.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final void Function(Category?) onTap;

  const CategoryList(this.categories, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    final bodySmall2 = Theme.of(context).textTheme.bodySmall;
    final bodyMedium2 = Theme.of(context).textTheme.bodyMedium;

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Text(
          'Puedes elegir una Categoría disponible para asignar a tu Actividad.',
          style: bodyMedium2?.copyWith(color: Colors.black87),
        ),
        const SizedBox(height: 16.0),
        Text(
          "Disponibles (${categories.length})",
          style: bodySmall2?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        ...categories.map(_buildCategoryItemList),
      ],
    );
  }

  Widget _buildCategoryItemList(Category category) {
    return CategoryListItem(
      category: category,
      subcategories: const [],
      onTap: (categoryId) {
        onTap(category);
      },
    );
  }
}
