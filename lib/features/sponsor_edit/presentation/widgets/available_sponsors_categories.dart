import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/sponsor_category/domain/entities/sponsors_category_model.dart';
import 'package:pamphlets_management/features/sponsor_category/presentation/bloc/sponsors_category_get/sponsors_category_bloc.dart';
import 'package:pamphlets_management/features/sponsor_category/presentation/bloc/sponsors_category_delete/sponsors_category_delete_bloc.dart';
import 'package:pamphlets_management/features/sponsor_edit/presentation/widgets/category_sponsors_list.dart';


class AvailableSponsorsCategories extends StatelessWidget {
  final int eventId;
  final void Function(SponsorsCategoryModel?) _onSelected;
  const AvailableSponsorsCategories(this._onSelected, {super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return SponsorsCategoryBloc(GetIt.instance.get())
              ..add(CategorySponsorsStart(eventId: eventId));
          },
        ),
        BlocProvider(
          create: (context) => SponsorsCategoryDeleteBloc(GetIt.instance.get()),
        ),
      ],
      child: Center(
        child: BlocBuilder<SponsorsCategoryBloc, SponsorsCategoryState>(
          builder: (context, state) {
            if (state is SponsorsCategoryLoading) {
              return const CupertinoActivityIndicator();
            }

            if (state is SponsorsCategoryFailure) {
              return Text(state.msgFail);
            }

            if (state is SponsorsCategorySuccess) {
              return CategorySponsorsList(
                  eventId: eventId,
                  state.lstCategorySponsor, _onSelected);
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
