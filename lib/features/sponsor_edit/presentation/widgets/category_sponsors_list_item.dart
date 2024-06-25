import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/presentation/bloc/sponsors_category_get/sponsors_category_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/presentation/bloc/sponsors_category_delete/sponsors_category_delete_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/presentation/bloc/sponsors_category_edit/sponsors_category_edit_bloc.dart';
import 'package:pamphlets_management/utils/common/custom_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class CategorySponsorsListItem extends StatefulWidget {
  final int eventId;
  final SponsorsCategoryModel categorySponsors;
  final void Function(int) onTap;

  const CategorySponsorsListItem({
    super.key,
    required this.categorySponsors,
    required this.onTap,
    required this.eventId
  });

  @override
  State<CategorySponsorsListItem> createState() =>
      _CategorySponsorsListItemState();
}

class _CategorySponsorsListItemState extends State<CategorySponsorsListItem>
    with Toaster {
  bool _isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    final titleSmall2 = Theme.of(context).textTheme.titleSmall;

    return BlocListener<SponsorsCategoryDeleteBloc,
            SponsorsCategoryDeleteState>(
        listener: (context, state) {
          if (state is SponsorsDeleteFailure) {
            showToast(context: context, message: state.msgFail);
          }
          if (state is SponsorsDeleteSuccess) {
            showToast(context: context, message: 'Categoría eliminada');
            BlocProvider.of<SponsorsCategoryBloc>(context)
                .add(CategorySponsorsStart(eventId: widget.eventId));
          }
        },
        child: MouseRegion(
          onEnter: (_) => _showButtons(true),
          onExit: (_) => _showButtons(false),
          child: ListTile(
            title: Row(
              children: [
                Expanded(child: Text(widget.categorySponsors.spcName!)),
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
            leading: BlocBuilder<SponsorsCategoryDeleteBloc,
                SponsorsCategoryDeleteState>(
              builder: (context, state) {
                if (state is SponsorsDeleteLoading) {
                  return const CupertinoActivityIndicator();
                }
                return const Icon(Icons.category);
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
            onTap: () => widget.onTap(widget.categorySponsors.spcId!),
          ),
        ));
  }

  void _showButtons(bool isVisible) {
    setState(() {
      _isHighlighted = isVisible;
    });
  }

  Text? _validateDescription() {
    return widget.categorySponsors.spcDescription != null
        ? Text(widget.categorySponsors.spcDescription!)
        : null;
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
          BlocProvider.of<SponsorsCategoryDeleteBloc>(context).add(
            SponsorsDeleteStart(spcId: widget.categorySponsors.spcId!),
          );
        },
      ),
    );
  }

  void _editCategory() async {
    BlocProvider.of<SponsorsCategoryEditBloc>(context)
        .add(CategoryUpdaterLoadedForm(
      widget.categorySponsors,
    ));
  }
}
