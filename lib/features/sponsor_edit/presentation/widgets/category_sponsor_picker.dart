import 'package:flutter/material.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_edit/presentation/widgets/category_sponsor_panel.dart';




class CategorySponsorPicker extends StatelessWidget {
  final int eventId;
  final void Function(SponsorsCategoryModel?) _onSelect;
  const CategorySponsorPicker(this._onSelect, {super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog(
        context: context,
        builder: _showCategoryDialog,
        barrierColor: Colors.transparent,
      ),
      child: const Text("Elegir categoría"),
    );
  }

  Widget _showCategoryDialog(BuildContext context) {
    return Dialog(
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      alignment: Alignment.topCenter,
      child: CategorySponsorPanel(onSelected:_onSelect,eventId: eventId),
    );
  }
}
