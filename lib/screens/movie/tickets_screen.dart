import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/bloc/booking_details_bloc.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/movie/payment_screen.dart';
import 'package:movies/utils/date_formatter.dart';
import 'package:movies/widget/dates_list.dart';
import 'package:movies/widget/seats_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketsScreen extends ConsumerStatefulWidget {
  const TicketsScreen({super.key});

  @override
  ConsumerState<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends ConsumerState<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 250, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        title: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              ref.read(movieProvider).title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'In theaters ${formatDate(ref.read(movieProvider).releaseDate)}',
              style: const TextStyle(
                color: Color.fromRGBO(97, 195, 242, 1),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const Expanded(flex: 10, child: SizedBox()),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Date',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(32, 44, 67, 1),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const DatesList(),
            const SizedBox(height: 25),
            const SeatsList(),
            const Expanded(flex: 20, child: SizedBox()),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(97, 195, 242, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      if (state is BookingDetailsLoaded &&
                          (state.bookingDetails.date == '' ||
                              state.bookingDetails.time == '')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select time and Date"),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.fixed,
                          ),
                        );

                        return;
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const PaymentScreen();
                      }));
                    },
                    child: const Text(
                      ' Select Seats',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
