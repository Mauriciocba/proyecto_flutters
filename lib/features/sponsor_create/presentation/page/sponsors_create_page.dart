import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/sponsor_create/domain/use_cases/register_sponsor_use_case.dart';
import 'package:pamphlets_management/features/sponsor_create/presentation/bloc/create_sponsors_bloc.dart';
import 'package:pamphlets_management/features/sponsor_create/presentation/widgets/form_sponsors_widget.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';
import 'package:flutter/material.dart';

class SponsorsCreatePage extends StatelessWidget with Toaster {
  final int eventId;
  const SponsorsCreatePage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return CardScaffold(
        appBar: CustomAppBar(
          title: "Crear Sponsors",
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left_rounded)),
        ),
        body: BlocProvider(
            create: (_) => CreateSponsorsBloc(GetIt.instance.get<RegisterSponsorUseCase>()),
            child:
                BlocListener<CreateSponsorsBloc, CreateSponsorsState>(listener: (context, state) {
              if (state is CreateSponsorFailure) {
                showToast(
                  context: context,
                  message: 'No se pudo registrar',
                  isError: true,
                );
              }
              if (state is CreateSponsorSuccess) {
                showToast(
                  context: context,
                  message: 'Sponsor Registrado.',
                );
              }
            },
            child: SingleChildScrollView(
              child: Center(child: FormSponsorsWidget(eventId: eventId)),
            ),
            )));
  }
}
