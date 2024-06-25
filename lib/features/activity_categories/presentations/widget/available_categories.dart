import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/activity_categories/domain/entities/category.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/bloc/categories_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/bloc/category_remover_bloc.dart';
import 'package:pamphlets_management/features/activity_categories/presentations/widget/category_list.dart';

class AvailableCategories extends StatelessWidget {
  final void Function(Category?) _onSelected;
  const AvailableCategories(this._onSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return CategoriesBloc(GetIt.instance.get())
              ..add(FetchedCategories());
          },
        ),
        BlocProvider(
          create: (context) => CategoryRemoverBloc(GetIt.instance.get()),
        ),
      ],
      child: Center(
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoadInProgress) {
              return const CupertinoActivityIndicator();
            }

            if (state is CategoriesLoadFailure) {
              return Text(state.message);
            }

            if (state is CategoriesLoadSuccess) {
              return CategoryList(state.categories, _onSelected);
            }

            return Text(
              'Sin categorías registradas',
              style: Theme.of(context).textTheme.labelLarge,
            );
          },
        ),
      ),
    );
  }
}
