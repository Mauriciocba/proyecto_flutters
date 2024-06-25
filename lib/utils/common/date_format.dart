import 'package:intl/intl.dart';

String formatterDate(DateTime dateTime) {
  return DateFormat('d/M/y').format(dateTime);
}

String formatterTime(DateTime dateTime) {
  return DateFormat(DateFormat.HOUR24_MINUTE).format(dateTime);
}
