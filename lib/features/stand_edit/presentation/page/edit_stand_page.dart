import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/stand_edit/domain/entities/stands_edit_model.dart';
import 'package:pamphlets_management/features/stand_edit/presentation/bloc/edit_stand_bloc.dart';
import 'package:pamphlets_management/features/stand_edit/presentation/widgets/edit_stand_widget.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';

import '../../../../utils/common/toaster.dart';
import '../../domain/use_cases/edit_stand_use_case.dart';

class EditStandsPage extends StatelessWidget with Toaster {
  final StandsEditModel standModel;
  const EditStandsPage({super.key,required  this.standModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditStandBloc(GetIt.instance.get<EditStandsUseCase>()),
      child: CardScaffold(
        appBar: CustomAppBar(
          title: "Editar Stand",
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
          child: BlocListener<EditStandBloc, EditStandState>(
            listener: (context, state) {
              if (state is EditStandSuccess) {
                showToast(context: context, message: "Stand actualizado");
                Navigator.of(context).pop();
              }
              if (state is EditStandFailure) {
                showToast(
                  context: context,
                  message: "No se pudo realizar los cambios",
                  isError: true,
                );
              }
              if (state is LoadStandsEditFail) {
                showToast(
                  context: context,
                  message: "Hubo un problema, intente nuevamente",
                  isError: true,
                );
              }
            },
            child: BlocBuilder<EditStandBloc, EditStandState>(
              builder: (context, state) {
                if (state is LoadStandsEditLoading) {
                  return const CupertinoActivityIndicator();
                }
                return EditStandWidget(
                  standModel: standModel,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
