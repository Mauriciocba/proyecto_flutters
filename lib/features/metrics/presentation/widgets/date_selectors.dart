import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// import '../../../../utils/common/custom_textfield.dart';
import '../../../../utils/common/date_format.dart';
import '../../../../utils/common/date_textfield.dart';
import '../../../../utils/common/toaster.dart';

class DateSelectorsWidget extends StatefulWidget {
  const DateSelectorsWidget({
    super.key,
    required this.onPressedFilter,
  });
  final void Function(DateTime, DateTime) onPressedFilter;

  @override
  State<DateSelectorsWidget> createState() => _DateSelectorsWidgetState();
}

class _DateSelectorsWidgetState extends State<DateSelectorsWidget>
    with Toaster {
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  bool isSearchButtonEnabled = false;

  @override
  void initState() {
    _startDateController =
        TextEditingController(text: formatterDate(DateTime.now()));
    _endDateController =
        TextEditingController(text: formatterDate(DateTime.now()));
    checkIfSearchButtonShouldBeEnabled();
    super.initState();
  }

  DateTime parseDate(String dateTime) {
    DateTime parsedDateTime = DateFormat('dd/MM/yyyy').parse(dateTime);

    parsedDateTime =
        DateTime(parsedDateTime.year, parsedDateTime.month, parsedDateTime.day);

    return parsedDateTime;
  }

  void checkIfSearchButtonShouldBeEnabled() {
    final startDate = parseDate(_startDateController.text);
    final endDate = parseDate(_endDateController.text);
    setState(() {
      isSearchButtonEnabled =
          !endDate.isBefore(startDate) || endDate.isAtSameMomentAs(startDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: DateTextField(
                label: "Fecha de inicio",
                controller: _startDateController,
                firstDate:
                    DateTime.now().subtract(const Duration(days: 5 * 365)),
                lastDate: DateTime.now().add(const Duration(days: 5 * 365)),
                enabledButton: () {
                  checkIfSearchButtonShouldBeEnabled();
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: DateTextField(
                label: "Fecha de fin",
                controller: _endDateController,
                firstDate: _startDateController.text.isNotEmpty
                    ? parseDate(_startDateController.text)
                    : DateTime.now().subtract(const Duration(days: 5 * 365)),
                lastDate: DateTime.now().add(const Duration(days: 5 * 365)),
                currentDate: _startDateController.text.isNotEmpty
                    ? parseDate(_startDateController.text)
                    : DateTime.now().subtract(const Duration(days: 5 * 365)),
                enabledButton: () {
                  checkIfSearchButtonShouldBeEnabled();
                },
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: isSearchButtonEnabled
              ? () {
                  widget.onPressedFilter(parseDate(_startDateController.text),
                      parseDate(_endDateController.text));
                }
              : null,
          child: const Text('BUSCAR POR FECHA'),
        ),
      ],
    );
  }
}
