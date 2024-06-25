import 'package:flutter/material.dart';
import 'package:pamphlets_management/utils/common/custom_textfield.dart';
import 'package:pamphlets_management/utils/common/date_format.dart';

class DateTextField extends StatelessWidget {
  const DateTextField({
    super.key,
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    this.firstDate,
    this.lastDate,
    this.enabledButton,
    this.currentDate,
  })  : _controller = controller,
        _label = label,
        _validator = validator;

  final TextEditingController _controller;
  final String _label;
  final String? Function(String?)? _validator;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? currentDate;
  final void Function()? enabledButton;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: _label,
      readOnly: true,
      controller: _controller,
      prefix: const Icon(Icons.calendar_month_outlined),
      suffix: const Icon(Icons.arrow_drop_down),
      validator: _validator,
      onTap: () async {
        var selectedDate = await showDatePicker(
          context: context,
          firstDate: firstDate ?? DateTime.now(),
          lastDate: lastDate ?? DateTime(2030),
          currentDate: DateTime.now(),
        );
        if (selectedDate != null) {
          _controller.text = formatterDate(selectedDate);
          enabledButton;
        }
      },
    );
  }
}
