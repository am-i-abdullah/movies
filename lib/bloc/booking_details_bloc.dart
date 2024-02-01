import 'package:bloc/bloc.dart';

import 'package:movies/models/booking_details.dart';

part 'booking_details_event.dart';
part 'booking_details_state.dart';

class BookingDetailsBloc
    extends Bloc<BookingDetailsEvent, BookingDetailsState> {
  BookingDetailsBloc() : super(BookingDetailsInitial()) {
    on<UpdateBookingDetailsEvent>((event, emit) {
      BookingDetails bd = BookingDetails();
      bd.date = event.newDate;
      bd.time = event.newTime;
      emit(BookingDetailsLoaded(bookingDetails: bd));
    });
  }
}
