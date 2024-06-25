import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';

import '../../../../utils/common/toaster.dart';
import '../../domain/use_cases/create_event_use_case.dart';
import '../bloc/create_event_bloc.dart';
import '../widgets/widget_form_create_event.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> with Toaster {
  UniqueKey _key = UniqueKey();
  ScrollController? scrollControllerCreateEvent;

  void _newKey() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollControllerCreateEvent = PrimaryScrollController.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateEventBloc(GetIt.instance.get<CreateEventUseCase>()),
      child: BlocListener<CreateEventBloc, CreateEventState>(
        listener: (context, state) {
          if (state is CreateEventFailure) {
            showToast(
              context: context,
              message: state.errorMessage,
              isError: true,
            );
          }
          if (state is CreateEventSuccess) {
            showToast(context: context, message: 'Creación confirmada');
            Navigator.pop(context, true);
            _newKey();
          }
        },
        child: CardScaffold(
            key: myKeyScaffold,
            appBar: CustomAppBar(
                leading: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_left_rounded),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                title: 'Crear Evento'),
            body: GestureDetector(
              onTap: () {},
              child: SingleChildScrollView(
                controller: scrollControllerCreateEvent,
                child: Center(
                  child: WidgetFormCreateEvent(key: _key),
                ),
              ),
            )),
      ),
    );
  }
}
