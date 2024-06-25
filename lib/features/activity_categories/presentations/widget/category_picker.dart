import 'package:flutter/material.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/widget/category_panel.dart';

class CategoryPicker extends StatelessWidget {
  final void Function(Category?) _onSelect;
  const CategoryPicker(this._onSelect, {super.key});

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
      child: CategoryPanel(onSelected: _onSelect),
    );
  }
}
