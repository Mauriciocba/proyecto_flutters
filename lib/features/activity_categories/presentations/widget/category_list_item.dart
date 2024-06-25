import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/bloc/categories_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/bloc/category_remover_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/bloc/category_updater_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class CategoryListItem extends StatefulWidget {
  final Category category;
  final List<Widget> subcategories;
  final void Function(int) onTap;

  const CategoryListItem({
    super.key,
    required this.category,
    required this.subcategories,
    required this.onTap,
  });

  @override
  State<CategoryListItem> createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> with Toaster {
  bool _isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final titleSmall2 = Theme.of(context).textTheme.titleSmall;

    return BlocListener<CategoryRemoverBloc, CategoryRemoverState>(
      listener: (context, state) {
        if (state is CategoryRemoverFailure) {
          showToast(context: context, message: state.message);
        }
        if (state is CategoryRemoverSuccess) {
          showToast(context: context, message: state.message);
          BlocProvider.of<CategoriesBloc>(context).add(FetchedCategories());
        }
      },
      child: MouseRegion(
        onEnter: (_) => _showButtons(true),
        onExit: (_) => _showButtons(false),
        child: ListTile(
          title: Row(
            children: [
              Expanded(child: Text(widget.category.name)),
              ..._buildSubCategories(),
            ],
          ),
          trailing: !_isHighlighted
              ? const SizedBox()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filled(
                      padding: EdgeInsets.zero,
                      splashRadius: 16.0,
                      iconSize: 16.0,
                      onPressed: _editCategory,
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton.filled(
                      padding: EdgeInsets.zero,
                      splashRadius: 16.0,
                      iconSize: 16.0,
                      onPressed: _deleteCategory,
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
          subtitle: _validateDescription(),
          leading: BlocBuilder<CategoryRemoverBloc, CategoryRemoverState>(
            builder: (context, state) {
              if (state is CategoryRemoverInProgress) {
                return const CupertinoActivityIndicator();
              }
              return Icon(_validateIconData(), size: 16, color: Colors.black87);
            },
          ),
          dense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          minLeadingWidth: 4,
          minVerticalPadding: 10,
          hoverColor: Colors.grey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          titleTextStyle: titleSmall2?.copyWith(color: Colors.black87),
          onTap: () => widget.onTap(widget.category.categoryId),
        ),
      ),
    );
  }

  void _showButtons(bool isVisible) {
    setState(() {
      _isHighlighted = isVisible;
    });
  }

  Text? _validateDescription() {
    return widget.category.description != null
        ? Text(widget.category.description!)
        : null;
  }

  List<Widget> _buildSubCategories() {
    return List.generate(
        widget.subcategories.length, (index) => widget.subcategories[index]);
  }

  IconData _validateIconData() {
    try {
      if (widget.category.iconName == null) return Icons.sell;
      return IconData(
        int.parse(widget.category.iconName!),
        fontFamily: 'MaterialIcons',
      );
    } catch (_) {
      return Icons.sell;
    }
  }

  void _deleteCategory() {
    showDialog(
      context: context,
      builder: (_) => CustomDialog(
        title: "¿Desea eliminar ésta categoría?",
        description:
            "Presiona \"Eliminar\" si está seguro de eliminar la categoría.",
        confirmLabel: "Eliminar",
        confirm: () {
          BlocProvider.of<CategoryRemoverBloc>(context).add(
            CategoryRemoverPressed(categoryId: widget.category.categoryId),
          );
        },
      ),
    );
  }

  void _editCategory() async {
    BlocProvider.of<CategoryUpdaterBloc>(context).add(CategoryUpdaterLoadedForm(
      widget.category,
    ));
  }
}
