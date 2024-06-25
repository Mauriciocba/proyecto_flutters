import 'package:flutter/material.dart';

class WidgetUtcSelector extends StatefulWidget {
  const WidgetUtcSelector(
      {super.key,
      required this.listEvents,
      required this.onEventSelected,
      this.initialValue});
  final List<String> listEvents;
  final void Function(String) onEventSelected;
  final String? initialValue;

  @override
  State<WidgetUtcSelector> createState() => _WidgetUtcSelectorState();
}

class _WidgetUtcSelectorState extends State<WidgetUtcSelector> {
  String utcSelected = '';

  @override
  void initState() {
    super.initState();
    if (widget.listEvents.isNotEmpty) {
      utcSelected = widget.initialValue ?? widget.listEvents.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: widget.listEvents.isEmpty
          ? const Text('No se cargó los indices utc')
          : const Text('Selecciona el indice utc'),
      value: utcSelected,
      isExpanded: true,
      onChanged: (newValue) {
        if (newValue != null) {
          final selectedEventModel = widget.listEvents.firstWhere(
            (event) => event == newValue,
            orElse: () => widget.listEvents.first,
          );
          setState(() {
            utcSelected = selectedEventModel;
          });

          widget.onEventSelected(utcSelected);
        }
      },
      items: widget.listEvents.isNotEmpty
          ? widget.listEvents
              .map((event) => event)
              .toSet()
              .map((eventName) => DropdownMenuItem<String>(
                    value: eventName.toString(),
                    child: Text(
                      eventName.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ))
              .toList()
          : null,
    );
  }
}
