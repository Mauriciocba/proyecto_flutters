import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventFormHelpers {
  static TimeOfDay timeOfDayFromText(String text) {
    final format = DateFormat.jm();
    final dateTimeParse = format.parse(text);
    return TimeOfDay.fromDateTime(dateTimeParse);
  }

  static bool isTimeValid(
      TextEditingController startController,
      TextEditingController timeStartController,
      TextEditingController endController,
      TextEditingController timeEndController) {
    DateTime parsedDateStart =
        getDateTimeComplete(startController, timeStartController);
    DateTime parsedDateEnd =
        getDateTimeComplete(endController, timeEndController);

    return (parsedDateEnd.isAfter(parsedDateStart));
  }

  static DateTime getDateTimeComplete(TextEditingController dTimeController,
      TextEditingController timeController) {
    DateTime parsedDateTime =
        DateFormat('dd/MM/yyyy').parse(dTimeController.text);

    parsedDateTime = DateTime(
      parsedDateTime.year,
      parsedDateTime.month,
      parsedDateTime.day,
      DateFormat("HH:mm").parse(timeController.text).hour,
      DateFormat("HH:mm").parse(timeController.text).minute,
    );
    return parsedDateTime;
  }

  static bool areDatesEqual(
    TextEditingController startController,
    TextEditingController endController,
  ) {
    DateTime startDate = DateFormat('dd/MM/yyyy').parse(startController.text);
    DateTime endDate = DateFormat('dd/MM/yyyy').parse(endController.text);

    return startDate.isAtSameMomentAs(endDate);
  }
}
