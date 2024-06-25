import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/stand_create/domain/use_cases/register_stands_use_case.dart';
import 'package:pamphlets_management/features/stand_create/presentation/bloc/stands_create_bloc.dart';
import 'package:pamphlets_management/features/stand_create/presentation/widgets/form_create_stands.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:flutter/material.dart';

class StandsCreatePage extends StatelessWidget with Toaster {
  final int eventId;
  const StandsCreatePage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return CardScaffold(
        appBar: CustomAppBar(
          title: "Crear Stand",
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left_rounded)),
        ),
        body: BlocProvider(
            create: (_) => StandsCreateBloc(GetIt.instance.get<RegisterStandsUseCase>()),
            child:
                BlocListener<StandsCreateBloc, StandsCreateState>(listener: (context, state) {
              if (state is StandsCreateFailure) {
                showToast(
                  context: context,
                  message: 'No se pudo registrar',
                  isError: true,
                );
              }
              if (state is StandsCreateSuccess) {
                showToast(
                  context: context,
                  message: 'Stand Registrado.',
                );
              }
            },
            child: SingleChildScrollView(
              child: Center(child: FormStandsWidget(eventId: eventId)),
            ),
            )));
  }
}
