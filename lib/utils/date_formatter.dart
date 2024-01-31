import 'package:intl/intl.dart';

String formatDate(String date) {
  DateTime date0 = DateTime.parse(date);

  String formattedDate = DateFormat('MMMM dd, y').format(date0);

  return formattedDate;
}
