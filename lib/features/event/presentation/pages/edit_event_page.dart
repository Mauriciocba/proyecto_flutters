import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/event/domain/use_cases/edit_event_use_case.dart';
import 'package:pamphlets_management/features/event/domain/use_cases/info_event_use_case.dart';
import 'package:pamphlets_management/features/event/presentation/bloc/bloc/event_all_bloc.dart';
import 'package:pamphlets_management/features/event/presentation/widgets/widget_form_edit_event.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

import '../bloc/edit_event_bloc.dart';

class EditEventPage extends StatefulWidget {
  const EditEventPage({super.key, required this.eventId});

  final int eventId;

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> with Toaster {
  UniqueKey _key = UniqueKey();
  ScrollController? scrollControllerEditEventPage;

  void _newKey() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollControllerEditEventPage = PrimaryScrollController.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditEventBloc(
        GetIt.instance<EditEventUseCase>(),
        GetIt.instance<GetInfoEventUseCase>(),
      )..add(EditEventLoad(eventId: widget.eventId)),
      child: BlocListener<EditEventBloc, EditEventState>(
        listener: (context, state) {
          if (state is EditEventConfirmFailure) {
            showToast(
              context: context,
              message: state.errorMessage,
              isError: true,
            );
          }
          if (state is EditEventConfirmChange) {
            showToast(
              context: context,
              message: 'Evento editado exitosamente',
            );
            _newKey();
            context.read<EventAllBloc>().add(EventAllStart());
            Navigator.pop(context);
          }
        },
        child: CardScaffold(
          key: myKeyScaffold,
          appBar: CustomAppBar(
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_left_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: 'Editar evento',
          ),
          body: BlocBuilder<EditEventBloc, EditEventState>(
            builder: (context, state) {
              if (state is EditEventFailure) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              if (state is EditEventLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (state is EditEventSuccess) {
                return SingleChildScrollView(
                  controller: scrollControllerEditEventPage,
                  child: Center(
                    child: WidgetFormEditEvent(
                      key: _key,
                      eventLoaded: state.eventSelected,
                    ),
                  ),
                );
              }
              return const Center(
                child: Text('No se pudo obtener los datos'),
              );
            },
          ),
        ),
      ),
    );
  }
}
