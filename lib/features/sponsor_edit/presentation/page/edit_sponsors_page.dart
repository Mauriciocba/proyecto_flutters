import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/entities/sponsors_edit_model.dart';
import 'package:pamphlets_management/features/sponsor_edit/domain/use_cases/edit_sponsor_use_case.dart';
import 'package:pamphlets_management/features/sponsor_edit/presentation/bloc/edit_sponsors_bloc.dart';
import 'package:pamphlets_management/features/sponsor_edit/presentation/widgets/edit_sponsor_widget.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';

import '../../../../utils/common/toaster.dart';
import 'package:flutter/material.dart';

class EditSponsorsPage extends StatelessWidget with Toaster {
  final int eventId;
  final SponsorsEditModel sponsorEditModel;
  const EditSponsorsPage({super.key,required  this.sponsorEditModel,required this.eventId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditSponsorsBloc(GetIt.instance.get<EditSponsorsUseCase>()),
      child: CardScaffold(
        appBar: CustomAppBar(
          title: "Editar Sponsor",
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 24.0,
          ),
          child: BlocListener<EditSponsorsBloc, EditSponsorsState>(
            listener: (context, state) {
              if (state is EditSponsorsSuccess) {
                showToast(context: context, message: "Sponsor actualizado");
                Navigator.of(context).pop();
              }
              if (state is EditSponsorsFail) {
                showToast(
                  context: context,
                  message: "No se pudo realizar los cambios",
                  isError: true,
                );
              }
              if (state is LoadSponsorsFailure) {
                showToast(
                  context: context,
                  message: "Hubo un problema, intente nuevamente",
                  isError: true,
                );
              }
            },
            child: BlocBuilder<EditSponsorsBloc, EditSponsorsState>(
              builder: (context, state) {
                if (state is LoadSponsorsLoading) {
                  return const CupertinoActivityIndicator();
                }
                return EditSponsorWidget(
                  eventId: eventId,
                  sponsorsModel: sponsorEditModel,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
