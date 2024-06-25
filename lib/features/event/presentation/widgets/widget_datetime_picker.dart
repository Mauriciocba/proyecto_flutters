import 'package:flutter/material.dart';

import 'inputs_decoration.dart';

class WidgetDateTimePicker extends StatefulWidget {
  const WidgetDateTimePicker({
    super.key,
    required this.selectedDate,
    required this.dateTimeInitial,
    this.controller,
    required this.onDateSelected,
    required this.labelText,
  });

  final TextEditingController? controller;
  final DateTime selectedDate;
  final DateTime dateTimeInitial;
  final String labelText;
  final VoidCallback? onDateSelected;

  @override
  State<WidgetDateTimePicker> createState() => _WidgetDateTimePickerState();
}

class _WidgetDateTimePickerState extends State<WidgetDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: widget.controller,
        readOnly: true,
        onTap: widget.onDateSelected,
        decoration: InputDecorations.authInputDecorations(
          isDateTimeSelect: true,
          labelText: widget.labelText,
          prefixIcon: Icons.edit_calendar_outlined,
        ),
      ),
    );
  }
}
