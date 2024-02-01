part of 'booking_details_bloc.dart';

abstract class BookingDetailsEvent {}

class UpdateBookingDetailsEvent extends BookingDetailsEvent {
  final String newTime;
  final String newDate;

  UpdateBookingDetailsEvent(this.newTime, this.newDate);
}
