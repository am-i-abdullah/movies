import 'package:intl/intl.dart';

String formatDate(String date) {
  DateTime parsedDate = DateTime.parse(date);

  String formattedDate = DateFormat('MMMM dd, y').format(parsedDate);

  return formattedDate;
}

String formatDayMonthDate() {
  return '';
}
