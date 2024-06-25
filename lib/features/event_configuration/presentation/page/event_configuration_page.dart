import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/event_configuration/domain/use_cases/event_configuration_edit_use_case.dart';
import 'package:pamphlets_management/features/event_configuration/domain/use_cases/event_configuration_use_case.dart';
import 'package:pamphlets_management/features/event_configuration/presentation/bloc/event_configuration_bloc.dart';
import 'package:pamphlets_management/features/event_configuration/presentation/widgets/widget_event_configuration.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class EventConfigurationPage extends StatelessWidget {
  final int eventId;
  const EventConfigurationPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => EventConfigurationBloc(
            GetIt.instance.get<GetEventConfigurationUseCase>(),
            GetIt.instance.get<EditConfigurationUseCase>())
          ..add(EventConfigurationStart(eventId: eventId)),
        child: _EventConfigurationBody(
          eventId: eventId,
        ));
  }
}

class _EventConfigurationBody extends StatelessWidget with Toaster {
  const _EventConfigurationBody({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventConfigurationBloc, EventConfigurationState>(
      listener: (context, state) {
        if(state is EditEventConfigurationFailure){
          showToast(context: context, message: state.msgFail);
        }
        if(state is EditEventConfigurationSuccess){
           showToast(context: context, message: 'Configuración Actualizada');
            context.read<EventConfigurationBloc>().add(EventConfigurationStart(eventId: eventId));
        }
      },
      child: CardScaffold(
          appBar: CustomAppBar(
            title: 'Configuración del Evento',
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.keyboard_arrow_left_rounded)),
          ),
          body: Column(
            children: [
              const Divider(height: 1.0),
              Expanded(child: _EventConfigInfoBody(eventId: eventId)),
            ],
          )),
    );
  }
}

class _EventConfigInfoBody extends StatelessWidget with Toaster {
  final int eventId;
  const _EventConfigInfoBody({
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventConfigurationBloc, EventConfigurationState>(
        builder: (context, state) {
      if (state is EventConfigurationLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is EventConfigurationFailure) {
        return Center(child: Text(state.msgFail));
      }
      if (state is EventConfigurationSuccess) {
        return WidgetEventConfiguration(
          eventId: eventId,
          eventConfig: state.modelConfiguration,
        );
      }
      return const Center(child: Text("No hay Datos"));
    });
  }
}
