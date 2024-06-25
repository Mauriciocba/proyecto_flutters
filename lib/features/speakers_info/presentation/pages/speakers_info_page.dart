import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/bloc/popup_menu_handler_bloc.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/page/popup_menu_handler.dart';
import 'package:pamphlets_management/features/speakers/presentation/page/new_speaker_page.dart';
import 'package:pamphlets_management/features/speakers_delete/domain/use_case/delete_speakers_use_case.dart';
import 'package:pamphlets_management/features/speakers_delete/presentation/bloc/delete_speaker_bloc.dart';
import 'package:pamphlets_management/features/speakers_info/domain/use_case/speakers_info_use_case.dart';
import 'package:pamphlets_management/features/speakers_info/presentation/bloc/speakers_info_bloc.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/pagination_bar.dart';
import 'package:pamphlets_management/utils/common/search_field.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

import '../widgets/speakers_list.dart';

class SpeakersInfoPage extends StatelessWidget {
  static const int limitOfResultPerPage = 10;
  static const int initialPage = 1;
  final int eventId;
  final String eventName;

  const SpeakersInfoPage(
      {super.key, required this.eventId, required this.eventName});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SpeakersInfoBloc(GetIt.instance.get<GetSpeakersInfoUseCase>())
                ..add(
                  SpeakersOnStart(
                    eventId: eventId,
                    page: initialPage,
                    limit: limitOfResultPerPage,
                    search: null,
                  ),
                ),
        ),
        BlocProvider(
          create: (context) => DeleteSpeakerBloc(
            GetIt.instance.get<GetDeleteSpeakerUseCase>(),
          ),
        ),
      ],
      child: _SpeakerInfoBody(eventId: eventId, eventName: eventName),
    );
  }
}

class _SpeakerInfoBody extends StatefulWidget {
  const _SpeakerInfoBody({
    required this.eventId,
    required this.eventName,
  });

  final int eventId;
  final String eventName;

  @override
  State<_SpeakerInfoBody> createState() => _SpeakerInfoBodyState();
}

class _SpeakerInfoBodyState extends State<_SpeakerInfoBody> with Toaster {
  late bool activeMenuOption = false;
  void _searchSpeakers({
    required BuildContext context,
    required int page,
    String? query,
  }) {
    if (page >= 0) {
      context.read<SpeakersInfoBloc>().add(
            SpeakersOnStart(
              eventId: widget.eventId,
              page: page,
              limit: SpeakersInfoPage.limitOfResultPerPage,
              search: query,
            ),
          );
    }
  }

  void _goCreateSpeakerForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewSpeakerPage(eventId: widget.eventId),
      ),
    ).then(
      (value) =>
          _searchSpeakers(context: context, page: SpeakersInfoPage.initialPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteSpeakerBloc, DeleteSpeakerState>(
      listener: (context, state) {
        if (state is DeleteSpeakerFailure) {
          showToast(context: context, message: state.msgFail);
        }
        if (state is DeleteSpeakerSuccess) {
          showToast(context: context, message: 'Speaker eliminado');
          _searchSpeakers(context: context, page: SpeakersInfoPage.initialPage);
        }
      },
      child: CardScaffold(
          appBar: CustomAppBar(
            title: 'Speakers',
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.keyboard_arrow_left_rounded)),
            trailing: Row(
              children: [
                Tooltip(
                  message: 'Crear Speaker',
                  child: IconButton(
                    onPressed: () => _goCreateSpeakerForm(context),
                    icon: const Icon(Icons.group_add),
                  ),
                ),
                if (activeMenuOption)
                  PopupMenuHandler(
                      eventId: widget.eventId,
                      popupMenuItemsGroup: PopupMenuItemsGroup.speakers,
                      eventName: widget.eventName)
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                width: 400,
                padding: const EdgeInsets.all(4.0),
                child: SearchField(onSearchSubmit: _searchSpeakers),
              ),
              const Divider(height: 1.0),
              Expanded(
                  child: SpeakerInfoWidget(
                eventId: widget.eventId,
                menuActive: (activeMenu) =>
                    setState(() => activeMenuOption = activeMenu),
              )),
              BlocBuilder<SpeakersInfoBloc, SpeakersInfoState>(
                builder: (context, state) {
                  return PaginationBar(
                    currentPage: (state.page != null && state.page! == 0)
                        ? "Todos"
                        : "${state.page}",
                    previous: () => _searchSpeakers(
                        context: context,
                        page: state.page != null ? state.page! - 1 : 1,
                        query: state.query),
                    next: () => _searchSpeakers(
                        context: context,
                        page: state.page != null ? state.page! + 1 : 1,
                        query: state.query),
                  );
                },
              )
            ],
          )),
    );
  }
}

class SpeakerInfoWidget extends StatelessWidget {
  const SpeakerInfoWidget({
    super.key,
    required this.eventId,
    required this.menuActive,
  });
  final Function(bool) menuActive;
  final int eventId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeakersInfoBloc, SpeakersInfoState>(
      listener: (context, state) {
        switch (state) {
          case SpeakersInfoFailure _:
            menuActive(false);
            break;
          case SpeakersInfoSuccess _:
            menuActive(true);
            break;
          default:
        }
      },
      child: BlocBuilder<SpeakersInfoBloc, SpeakersInfoState>(
          builder: (context, state) {
        if (state is SpeakersInfoLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is SpeakersInfoFailure) {
          return Center(child: Text(state.msgError));
        }
        if (state is SpeakersInfoSuccess) {
          return state.listSpeakers.isNotEmpty
              ? SpeakersList(eventId: eventId, listSpeakers: state.listSpeakers)
              : _EmptySpeakerList(eventId: eventId);
        }
        return const Center(child: Text("No hay Datos"));
      }),
    );
  }
}

class _EmptySpeakerList extends StatelessWidget {
  const _EmptySpeakerList({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text('No contiene Speakers'),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewSpeakerPage(eventId: eventId),
              ),
            );
          },
          child: const Text("Crear Speaker"),
        )
      ],
    );
  }
}
