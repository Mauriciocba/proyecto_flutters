import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/activities/presentation/bloc/new_activity_bloc/new_activity_bloc.dart';
import 'package:pamphlets_management/features/activities/presentation/widgets/new_activity_form.dart';
import 'package:pamphlets_management/features/speakers/presentation/bloc/bloc/create_speaker_bloc.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class NewActivityPage extends StatelessWidget with Toaster {
  const NewActivityPage({super.key, required int eventId}) : _eventId = eventId;

  final int _eventId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewActivityBloc(GetIt.instance.get()),
        ),
        BlocProvider(
          create: (context) => CreateSpeakerBloc(
            GetIt.instance.get(),
            GetIt.instance.get(),
          ),
        ),
      ],
      child: BlocListener<NewActivityBloc, NewActivityState>(
        listener: (context, state) {
          if (state is NewActivityRegisterFailure) {
            showToast(
              context: context,
              message: 'No se pudo guardar',
              isError: true,
            );
          }
          if (state is NewActivityRegisterSuccess) {
            showToast(
              context: context,
              message: 'Actividad registrada',
            );
            Navigator.of(context).pop();
          }
        },
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_left_rounded),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Nueva actividad",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1.0),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: NewActivityForm(eventId: _eventId),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
