import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/event/domain/entities/event.dart';
import 'package:pamphlets_management/features/event/presentation/bloc/bloc/event_all_bloc.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/bloc/popup_menu_handler_bloc.dart';
import 'package:pamphlets_management/features/popup_menu_handler/presentation/page/popup_menu_handler.dart';

import '../../../info_event/presentation/bloc/bloc/info_event_bloc.dart';

class EventsPanel extends StatefulWidget {
  final void Function(int, int) _onSelectEvent;
  // final int _initEventIndex;
  final bool _isEventSelected;

  const EventsPanel({
    super.key,
    // required int initEventIndex,
    required bool isEventSelected,
    required void Function(int, int) onSelectEvent,
  })  : _onSelectEvent = onSelectEvent,
        _isEventSelected = isEventSelected;
  // _initEventIndex = initEventIndex;

  @override
  State<EventsPanel> createState() => _EventsPanelState();
}

class _EventsPanelState extends State<EventsPanel> {
  late bool activeMenuOption = false;
  late int eventId = 0;
  late String eventName = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Mis eventos",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              if (activeMenuOption)
                const PopupMenuHandler(
                  popupMenuItemsGroup: PopupMenuItemsGroup.events,
                  eventName: '',
                  eventId: null,
                )
            ],
          ),
        ),
        Expanded(
          child: BlocListener<EventAllBloc, EventAllState>(
            listener: (context, state) {
              switch (state) {
                case EventAllSuccess _:
                  setState(() => activeMenuOption = true);
                  break;
                case EventAllFailure _:
                  setState(() => activeMenuOption = false);
                default:
              }
            },
            child: BlocBuilder<EventAllBloc, EventAllState>(
              builder: (context, state) {
                return Center(
                  child: switch (state) {
                    EventAllLoading() => const CupertinoActivityIndicator(),
                    EventAllInitial() => const SizedBox(),
                    EventAllFailure() => const Text("No tiene eventos"),
                    EventAllSuccess() => _EventList(
                        // initEventIndex: widget._initEventIndex,
                        isSelected: widget._isEventSelected,
                        events: state.event,
                        onTap: (event) {
                          widget._onSelectEvent(
                            event.eveId,
                            state.event.indexOf(event),
                          );
                          setState(() {
                            eventId = event.eveId;
                            eventName = event.eveName;
                          });
                        },
                      ),
                    NotLoggedIn() => const Text("No inició sesión"),
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _EventList extends StatefulWidget {
  final List<Event> _events;
  // final int _initEventIndex;
  final bool isSelected;
  final void Function(Event event) _onSelect;

  const _EventList({
    required List<Event> events,
    // required int initEventIndex,
    required this.isSelected,
    required void Function(Event) onTap,
  })  : _events = events,
        _onSelect = onTap;
  // _initEventIndex = initEventIndex;

  @override
  State<_EventList> createState() => _EventListState();
}

class _EventListState extends State<_EventList> {
  late int _selectedIndex = 0;

  bool _isSelected(int index) {
    return widget.isSelected && _selectedIndex == index;
  }

  @override
  void initState() {
    super.initState();

    if (widget.isSelected) {
      BlocProvider.of<InfoEventBloc>(context)
          .add(InfoEventStart(eventId: widget._events[_selectedIndex].eveId));
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;

    if (widget._events.isEmpty) return const Text("No contiene eventos");

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: widget._events.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2.0),
          child: ListTile(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget._onSelect(widget._events[index]);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            dense: true,
            selectedTileColor: colorTheme.primary.withOpacity(0.1),
            selected: _isSelected(index),
            leading: const Icon(
              Icons.today_outlined,
              size: 20,
            ),
            trailing: _isSelected(index)
                ? const Icon(Icons.keyboard_arrow_right_rounded)
                : null,
            title: Text(
              widget._events[index].eveName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight:
                    _isSelected(index) ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
