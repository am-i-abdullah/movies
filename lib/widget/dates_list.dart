import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movies/bloc/booking_details_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatesList extends ConsumerStatefulWidget {
  const DatesList({super.key});

  @override
  ConsumerState<DatesList> createState() => _DatesListState();
}

class _DatesListState extends ConsumerState<DatesList> {
  int selectedIndex = 0;
  List<String> dates = [];

  @override
  void initState() {
    super.initState();
    // generating list of next 15 days
    DateTime currentDate = DateTime.now();
    for (int i = 0; i < 14; i++) {
      String formattedDate = DateFormat('d MMM').format(currentDate);
      dates.add(formattedDate);
      // for next day
      currentDate = currentDate.add(const Duration(days: 1));

      context.read<BookingDetailsBloc>().add(UpdateBookingDetailsEvent(
            '',
            dates[0],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
      builder: (context, state) {
        selectedIndex =
            dates.indexOf((state as BookingDetailsLoaded).bookingDetails.date);
        return SizedBox(
          height: 35,
          child: ListView.builder(
            itemCount: dates.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  context
                      .read<BookingDetailsBloc>()
                      .add(UpdateBookingDetailsEvent(
                        '',
                        dates[index],
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(right: 7),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? const Color.fromRGBO(97, 195, 242, 1)
                        : const Color.fromRGBO(166, 166, 166, 0.1),
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  child: Center(
                    child: Text(
                      dates[index],
                      style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white
                            : const Color.fromRGBO(32, 44, 67, 1),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
