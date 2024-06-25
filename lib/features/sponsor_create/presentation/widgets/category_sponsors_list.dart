import 'package:flutter/material.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_create/presentation/widgets/category_sponsors_list_item.dart';


class CategorySponsorsList extends StatelessWidget {
  final int eventId;
  final List<SponsorsCategoryModel> lstCategoriesSponsors;
  final void Function(SponsorsCategoryModel?) onTap;

  const CategorySponsorsList(this.lstCategoriesSponsors, this.onTap,
      {super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final bodySmall2 = Theme.of(context).textTheme.bodySmall;
    final bodyMedium2 = Theme.of(context).textTheme.bodyMedium;

    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Text(
          'Puedes elegir una Categoría disponible para asignar a tu Sponsor.',
          style: bodyMedium2?.copyWith(color: Colors.black87),
        ),
        const SizedBox(height: 16.0),
        Text(
          "Disponibles (${lstCategoriesSponsors.length})",
          style: bodySmall2?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        ...lstCategoriesSponsors.map(_buildCategorySponsorsItemList),
      ],
    );
  }

  Widget _buildCategorySponsorsItemList(
      SponsorsCategoryModel categorySponsors) {
    return CategorySponsorsListItem(
      eventId: eventId,
      categorySponsors: categorySponsors,
      onTap: (categoryId) {
        onTap(categorySponsors);
      },
    );
  }
}
