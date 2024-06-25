import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/event/domain/entities/event.dart';
import 'package:pamphlets_management/features/metrics/presentation/bloc/select_activity_bloc.dart';

class EventsSelectorActivitiesMetrics extends StatefulWidget {
  const EventsSelectorActivitiesMetrics(
      {super.key, required this.listEvents, required this.onEventSelected});
  final List<Event> listEvents;
  final void Function(int) onEventSelected;

  @override
  State<EventsSelectorActivitiesMetrics> createState() =>
      _EventsSelectorActivitiesMetricsState();
}

class _EventsSelectorActivitiesMetricsState
    extends State<EventsSelectorActivitiesMetrics> {
  String? selectedEvent;
  int eventIdSelected = 0;

  @override
  void initState() {
    super.initState();
    if (widget.listEvents.isNotEmpty) {
      selectedEvent = widget.listEvents.first.eveName;
      eventIdSelected = widget.listEvents.first.eveId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: widget.listEvents.isEmpty
          ? const Text('No contiene eventos registrados')
          : const Text('Selecciona un evento'),
      value: selectedEvent,
      isExpanded: true,
      onChanged: (newValue) {
        if (newValue != null) {
          final selectedEventModel = widget.listEvents.firstWhere(
            (event) => event.eveName == newValue,
            orElse: () => widget.listEvents.first,
          );
          setState(() {
            selectedEvent = newValue;
            eventIdSelected = selectedEventModel.eveId;
          });
          BlocProvider.of<SelectActivityBloc>(context).add(LoadNewEvent(
              eventId: eventIdSelected, startDate: null, endDate: null));
        }
      },
      items: widget.listEvents.isNotEmpty
          ? widget.listEvents
              .map((event) => event.eveName)
              .toSet()
              .map((eventName) => DropdownMenuItem<String>(
                    value: eventName,
                    child: Text(
                      eventName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ))
              .toList()
          : null,
    );
  }
}
