import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:movies/bloc/booking_details_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatsList extends ConsumerStatefulWidget {
  const SeatsList({super.key});

  @override
  ConsumerState<SeatsList> createState() => _SeatsListState();
}

class _SeatsListState extends ConsumerState<SeatsList> {
  int? selectedIndex;
  String dateToday = '';
  String dateSelected = '';
  List<String> times = [
    '12:30',
    '13:30',
    '14:30',
    '15:30',
    '16:30',
    '17:30',
    '18:30',
    '19:30',
    '20:30',
    '21:30',
    '22:30'
  ];

  @override
  void initState() {
    super.initState();

    DateTime currentDate = DateTime.now();
    setState(() {
      dateToday = DateFormat('d MMM').format(currentDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingDetailsBloc, BookingDetailsState>(
      listener: (context, state) {
        if (state is BookingDetailsLoaded) {
          setState(() {
            dateSelected = state.bookingDetails.date;
          });
        }
      },
      child: SizedBox(
        height: 350,
        child: ListView.builder(
          itemCount: times.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            // incase today's time has been passed
            if (DateTime.now().hour >=
                    int.parse(times[index].substring(0, 2)) &&
                dateSelected == dateToday) {
              return const SizedBox();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: times[index],
                    style: const TextStyle(
                      color: Color.fromRGBO(32, 44, 67, 1),
                      fontSize: 15,
                    ),
                    children: const [
                      TextSpan(
                        text: '   Cinetech + Hall 1',
                        style: TextStyle(
                          color: Color.fromRGBO(143, 143, 143, 1),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      context
                          .read<BookingDetailsBloc>()
                          .add(UpdateBookingDetailsEvent(
                            times[index],
                            dateSelected,
                          ));
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedIndex == index
                            ? const Color.fromRGBO(97, 195, 242, 1)
                            : const Color.fromRGBO(166, 166, 166, 0.1),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12.5),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/seats.png',
                        // height: 270,
                        width: MediaQuery.of(context).size.width / 1.85,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                RichText(
                  text: const TextSpan(
                    text: 'From',
                    style: TextStyle(
                      color: Color.fromRGBO(143, 143, 143, 1),
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(
                        text: '\$50',
                        style: TextStyle(
                          color: Color.fromRGBO(32, 44, 67, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' or',
                        style: TextStyle(
                          color: Color.fromRGBO(143, 143, 143, 1),
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: ' \$200 bonus',
                        style: TextStyle(
                          color: Color.fromRGBO(32, 44, 67, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
