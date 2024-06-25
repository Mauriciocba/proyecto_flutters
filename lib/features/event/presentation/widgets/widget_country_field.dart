import 'package:flutter/material.dart';

import 'inputs_decoration.dart';

class WidgetCountryField extends StatefulWidget {
  const WidgetCountryField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.controller,
    this.isEnabled,
    this.stream,
    this.streamChange,
  });

  final TextEditingController? controller;
  final String hintText;
  final String labelText;
  final IconData? prefixIcon;
  final bool? isEnabled;
  final Stream<Object>? stream;
  final Function(String)? streamChange;

  @override
  State<WidgetCountryField> createState() => _WidgetCountryFieldState();
}

class _WidgetCountryFieldState extends State<WidgetCountryField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.isEnabled,
      readOnly: true,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecorations.authInputDecorations(
        enabledBorder: widget.isEnabled,
        disabledBorder: widget.isEnabled,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
      ),
    );
  }
}
