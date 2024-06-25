import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pamphlets_management/features/activities/domain/entities/activity.dart';
import 'package:pamphlets_management/features/activities/presentation/bloc/activities_bloc/activities_bloc.dart';
import 'package:pamphlets_management/features/activities/presentation/page/new_activity_page.dart';
import 'package:pamphlets_management/features/activities/presentation/widgets/activity_summary_card.dart';
import 'package:pamphlets_management/features/activities/presentation/widgets/empty_activities.dart';
import 'package:pamphlets_management/features/activity/delete_activity/presentation/bloc/delete_activity_bloc.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/bloc/popup_menu_handler_bloc.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/page/popup_menu_handler.dart';
import 'package:pamphlets_management/utils/common/card_scaffold.dart';
import 'package:pamphlets_management/utils/common/pagination_bar.dart';
import 'package:pamphlets_management/utils/common/search_field.dart';
import 'package:pamphlets_management/utils/common/toaster.dart';

const int _limitOfResultPerPage = 10;
const int _initialPage = 1;

class ActivitySummaryPage extends StatelessWidget {
  final int _selectedEventId;
  final String eventName;
  const ActivitySummaryPage(
      {super.key, required int eventId, required this.eventName})
      : _selectedEventId = eventId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivitiesBloc(GetIt.instance.get())
        ..add(RequestedActivities(
          eventId: _selectedEventId,
          limit: _limitOfResultPerPage,
          page: _initialPage,
        )),
      child: ActivitySummaryPanel(
          selectedEventId: _selectedEventId, eventName: eventName),
    );
  }
}

class ActivitySummaryPanel extends StatefulWidget {
  final int _selectedEventId;
  final String eventName;
  const ActivitySummaryPanel(
      {super.key, required int selectedEventId, required this.eventName})
      : _selectedEventId = selectedEventId;

  @override
  State<ActivitySummaryPanel> createState() => _ActivitySummaryPanelState();
}

class _ActivitySummaryPanelState extends State<ActivitySummaryPanel>
    with Toaster {
  late bool activeMenuOption = false;
  void _searchActivities({
    required BuildContext context,
    required int page,
    String? query,
  }) {
    if (page >= 0) {
      context.read<ActivitiesBloc>().add(
            RequestedActivities(
              eventId: widget._selectedEventId,
              page: page,
              limit: _limitOfResultPerPage,
              query: query,
            ),
          );
    }
  }

  void _createActivity(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewActivityPage(eventId: widget._selectedEventId),
      ),
    ).then(
      (_) => _searchActivities(context: context, page: _initialPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteActivityBloc, DeleteActivityState>(
      listener: (context, state) {
        if (state is DeleteActivitySuccess) {
          showToast(context: context, message: "Eliminado");
          Navigator.of(context).pop();
        }
        if (state is DeleteActivityFailure) {
          showToast(
            context: context,
            message: "No se pudo eliminar",
            isError: true,
          );
        }
      },
      child: CardScaffold(
        appBar: CustomAppBar(
          title: "Actividades",
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_left_rounded),
            onPressed: () => Navigator.pop(context),
          ),
          trailing: Row(
            children: [
              Tooltip(
                message: 'Crear Actividad',
                child: IconButton(
                  icon: const Icon(Icons.format_list_bulleted_add),
                  onPressed: () => _createActivity(context),
                ),
              ),
              if (activeMenuOption)
                PopupMenuHandler(
                  popupMenuItemsGroup: PopupMenuItemsGroup.activity,
                  eventId: widget._selectedEventId,
                  eventName: widget.eventName,
                )
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
                width: 400,
                padding: const EdgeInsets.all(8.0),
                child: SearchField(onSearchSubmit: _searchActivities)),
            const Divider(height: 1.0),
            Expanded(
              child: BlocListener<ActivitiesBloc, ActivitiesState>(
                listener: (context, state) {
                  switch (state) {
                    case ActivitiesLoadSuccess _:
                      setState(() => activeMenuOption = true);
                      break;
                    case ActivitiesLoadFailure _:
                      setState(() => activeMenuOption = false);
                      break;
                    default:
                  }
                },
                child: BlocBuilder<ActivitiesBloc, ActivitiesState>(
                  builder: (context, state) {
                    return Center(
                      child: switch (state) {
                        ActivitiesInitial() => const Text("cargando"),
                        ActivitiesOnLoading() =>
                          const CupertinoActivityIndicator(),
                        ActivitiesLoadFailure() => EmptyActivities(
                            selectedEventId: widget._selectedEventId,
                          ),
                        ActivitiesLoadSuccess() => _ActivitiesList(
                            eventId: widget._selectedEventId,
                            activities: state.activities,
                          ),
                      },
                    );
                  },
                ),
              ),
            ),
            BlocBuilder<ActivitiesBloc, ActivitiesState>(
              builder: (context, state) {
                return PaginationBar(
                  currentPage: (state.page != null && state.page! == 0)
                      ? "Todos"
                      : "${state.page}",
                  previous: () => _searchActivities(
                      context: context,
                      page: state.page != null ? state.page! - 1 : 1,
                      query: state.query),
                  next: () => _searchActivities(
                      context: context,
                      page: state.page != null ? state.page! + 1 : 1,
                      query: state.query),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _ActivitiesList extends StatelessWidget {
  final int _eventId;
  final Iterable<Activity> _activities;

  const _ActivitiesList(
      {required Iterable<Activity> activities, required int eventId})
      : _activities = activities,
        _eventId = eventId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            itemCount: _activities.length,
            itemBuilder: (context, index) {
              return ActivitySummaryCard(
                eventId: _eventId,
                activity: _activities.toList()[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
