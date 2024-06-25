import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/faq/presentation/bloc/faq_create/faq_create_bloc_bloc.dart';
import 'package:pamphlets_management/features/faq/presentation/bloc/faqs_bloc/faqs_bloc.dart';
import 'package:pamphlets_management/features/faq/presentation/bloc/faqs_delete_bloc/faqs_delete_bloc.dart';
import 'package:pamphlets_management/features/faq/presentation/bloc/faqs_update_bloc/faqs_update_bloc.dart';
import 'package:pamphlets_management/features/faq/presentation/page/create_faq_page.dart';
import 'package:pamphlets_management/features/faq/presentation/widgets/faqs_list.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/panel_dialog.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

class FaqPage extends StatelessWidget with Toaster {
  final int eventId;
  const FaqPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FaqsBloc(GetIt.instance.get())
            ..add(FaqsStarted(eventId: eventId)),
        ),
        BlocProvider(create: (_) => FaqsDeleteBloc(GetIt.instance.get())),
        BlocProvider(create: (_) => FaqsUpdateBloc(GetIt.instance.get())),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<FaqsBloc, FaqsState>(listener: _onFaqsBlocListener),
          BlocListener<FaqsDeleteBloc, FaqsDeleteState>(
              listener: _onFaqsDeleteListener),
          BlocListener<FaqsUpdateBloc, FaqsUpdateState>(
              listener: _onFaqsUpdateListener),
        ],
        child: Builder(
          builder: (context) {
            return CardScaffold(
              appBar: CustomAppBar(
                title: "Preguntas frecuentes",
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.keyboard_arrow_left_rounded)),
                trailing: Tooltip(
                  message: 'Crear FAQ',
                  child: IconButton(
                    onPressed: () => showPanelDialog(
                      context,
                      CreateFaqPage(
                        eventId: eventId,
                        onConfirm: () {
                          BlocProvider.of<FaqsBloc>(context).add(
                            FaqsStarted(eventId: eventId),
                          );
                        },
                      ),
                    ),
                    icon: const Icon(Icons.add_comment_rounded),
                  ),
                ),
              ),
              body: const FaqsList(),
            );
          },
        ),
      ),
    );
  }

  void _onFaqsBlocListener(context, state) {
    if (state is FaqCreateBlocFailure) {
      showToast(context: context, message: state.message, isError: true);
    }
  }

  void _onFaqsDeleteListener(BuildContext context, state) {
    if (state is FaqsDeleteSuccess) {
      showToast(context: context, message: 'Eliminado exitosamente');
      _updateList(context);
    }
    if (state is FaqsDeleteFailure) {
      showToast(context: context, message: state.message, isError: true);
    }
  }

  void _onFaqsUpdateListener(BuildContext context, state) {
    if (state is FaqsUpdateSuccess) {
      showToast(context: context, message: 'Actualizado exitosamente');
    }
    if (state is FaqsUpdateFailure) {
      showToast(context: context, message: state.message, isError: true);
    }
  }

  void _updateList(BuildContext context) {
    context.read<FaqsBloc>().add(FaqsStarted(eventId: eventId));
  }
}
