import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/domain/use_case/register_new_category_use_case.dart';
import 'package:pamphlets_management/features/activity_categories/domain/use_case/update_category_use_case.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/bloc/category_saver_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/bloc/category_updater_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/widget/available_categories.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/widget/category_register_form.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/widget/category_update_form.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class CategoryPanel extends StatefulWidget {
  final void Function(Category?) onSelected;
  const CategoryPanel({super.key, required this.onSelected});

  @override
  State<CategoryPanel> createState() => _CategoryPanelState();
}

class _CategoryPanelState extends State<CategoryPanel> with Toaster {
  bool _showCategoryForm = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategorySaverBloc(
              GetIt.instance.get<RegisterNewCategoryUseCase>()),
        ),
        BlocProvider(
          create: (_) => CategoryUpdaterBloc(
            GetIt.instance.get<UpdateCategoryUseCase>(),
          ),
        )
      ],
      child: BlocListener<CategoryUpdaterBloc, CategoryUpdaterState>(
        listener: (context, state) {
          if (state is CategoryUpdaterLoadFailure) {
            showToast(context: context, message: state.message, isError: true);
          }

          if (state is CategoryUpdaterLoadSuccess) {
            showToast(context: context, message: 'Registrado con éxito');
            context.pop();
          }
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              const _HeaderCategoryPanel('Categorías'),
              const Divider(height: 1.0),
              Expanded(
                child: BlocBuilder<CategoryUpdaterBloc, CategoryUpdaterState>(
                  builder: (context, state) {
                    if (state is CategoryUpdaterLoadForm) {
                      return CategoryUpdateForm(
                        category: state.category,
                        onCreated: (_) {},
                      );
                    } else {
                      return _showCategoryForm
                          ? CategoryRegisterForm(onCreated: widget.onSelected)
                          : AvailableCategories(widget.onSelected);
                    }
                  },
                ),
              ),
              BlocBuilder<CategoryUpdaterBloc, CategoryUpdaterState>(
                builder: (context, state) {
                  if (!_showCategoryForm) {
                    return _CreateCategoryPanelButton(
                      title: 'Nueva categoría',
                      onTap: () => setState(() {
                        _showCategoryForm = true;
                      }),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCategoryPanel extends StatelessWidget {
  final String title;

  const _HeaderCategoryPanel(this.title);

  @override
  Widget build(BuildContext context) {
    var titleMedium2 = Theme.of(context).textTheme.titleMedium;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleMedium2?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            iconSize: 16,
            padding: EdgeInsets.zero,
            splashRadius: 20,
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black45,
            ),
          )
        ],
      ),
    );
  }
}

class _CreateCategoryPanelButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final IconData _leading;

  const _CreateCategoryPanelButton({
    required this.title,
    required this.onTap,
    IconData leading = Icons.add,
  }) : _leading = leading;

  @override
  Widget build(BuildContext context) {
    var bodyMedium2 = Theme.of(context).textTheme.bodyMedium;

    return InkWell(
      onTap: () => onTap(),
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(10),
      ),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _leading,
              size: 20.0,
              color: Colors.black87,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: bodyMedium2?.copyWith(
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
