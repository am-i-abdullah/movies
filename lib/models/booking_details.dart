import 'dart:math';

class BookingDetails {
  late String time;
  late String date;
  late int seatNumber;

  BookingDetails() {
    seatNumber = Random().nextInt(99) + 1;
    date = '';
    time = '';
  }
}
