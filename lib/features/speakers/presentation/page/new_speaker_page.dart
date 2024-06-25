import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/social_media/domain/use_case/register_social_media.dart';

import 'package:pamphlets_management/features/speakers/domain/use_case/register_speaker_use_case.dart';
import 'package:pamphlets_management/features/speakers/presentation/bloc/bloc/create_speaker_bloc.dart';
import 'package:pamphlets_management/features/speakers/presentation/widgets/new_speaker_form.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';

import '../../../../utils/common/toaster.dart';

class NewSpeakerPage extends StatelessWidget with Toaster {
  final int eventId;
  const NewSpeakerPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return CardScaffold(
        appBar: CustomAppBar(
          title: 'Crear Speaker',
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left_rounded)),
        ),
        body: BlocProvider(
          create: (_) => CreateSpeakerBloc(
              GetIt.instance.get<RegisterSpeakerUseCase>(),
              GetIt.instance.get<RegisterSocialMediaUseCase>()),
          child: BlocListener<CreateSpeakerBloc, CreateSpeakerState>(
            listener: (context, state) {
              if (state is CreateSpeakerFailure) {
                showToast(
                  context: context,
                  message: 'No se pudo registrar',
                  isError: true,
                );
              }
              if (state is SocialMediaFail) {
                showToast(
                  context: context,
                  message: 'No se pudo registrar la red social',
                  isError: true,
                );
              }
              if (state is CreateSpeakerSuccess) {
                showToast(
                  context: context,
                  message: 'Speaker Registrado.',
                );
              }
              if (state is SocialMediaSuccess) {
                showToast(
                  context: context,
                  message: 'Red social Registrada.',
                );
              }
            },
            child: SingleChildScrollView(
              child: Center(child: NewSpeakerForm(eventId: eventId)),
            ),
          ),
        ));
  }
}
