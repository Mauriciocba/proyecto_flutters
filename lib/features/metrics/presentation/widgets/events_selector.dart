import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamphlets_management/features/metrics/domain/entities/logins_events_metrics_model.dart';

import '../bloc/metric_hour_bloc.dart';

class EventsSelector extends StatefulWidget {
  const EventsSelector(
      {super.key, required this.listEvents, required this.onEventSelected});
  final List<LoginsEventsMetricsModel> listEvents;
  final void Function(int) onEventSelected;

  @override
  State<EventsSelector> createState() => _EventsSelectorState();
}

class _EventsSelectorState extends State<EventsSelector> {
  String? selectedEvent;
  int eventIdSelected = 0;

  @override
  void initState() {
    super.initState();
    if (widget.listEvents.isNotEmpty) {
      selectedEvent = widget.listEvents.first.logins.eveName;
      eventIdSelected = widget.listEvents.first.logins.eveId;
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
            (event) => event.logins.eveName == newValue,
            orElse: () => widget.listEvents.first,
          );
          setState(() {
            selectedEvent = newValue;
            eventIdSelected = selectedEventModel.logins.eveId;
          });
          BlocProvider.of<MetricHourBloc>(context)
              .add(LoadMetricsHour(eventId: eventIdSelected));
          widget.onEventSelected(eventIdSelected);
        }
      },
      items: widget.listEvents.isNotEmpty
          ? widget.listEvents
              .map((event) => event.logins.eveName)
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
