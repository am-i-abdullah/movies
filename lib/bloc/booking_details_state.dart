part of 'booking_details_bloc.dart';

sealed class BookingDetailsState {}

class BookingDetailsInitial extends BookingDetailsState {
  BookingDetails bookingDetails = BookingDetails();
}

class BookingDetailsLoaded extends BookingDetailsState {
  final BookingDetails bookingDetails;

  BookingDetailsLoaded({required this.bookingDetails});
}
