import 'package:flutter/material.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/date_format.dart';

class TimeEditText extends StatelessWidget {
  const TimeEditText(
      {super.key,
      required TextEditingController controller,
      required String label,
      String? Function(String?)? validator,
      TimeOfDay? initialTime})
      : _controller = controller,
        _label = label,
        _validator = validator,
        _initialTime = initialTime;

  final TextEditingController _controller;
  final String _label;
  final String? Function(String?)? _validator;
  final TimeOfDay? _initialTime;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: _label,
      readOnly: true,
      controller: _controller,
      prefix: const Icon(Icons.access_time_outlined),
      validator: _validator,
      onTap: () async {
        var selectedTime = await showTimePicker(
            context: context, initialTime: _initialTime ?? TimeOfDay.now());

        if (selectedTime != null) {
          _controller.text = formatterTime(
              DateTime(1, 1, 1, selectedTime.hour, selectedTime.minute));
        }
      },
    );
  }
}
