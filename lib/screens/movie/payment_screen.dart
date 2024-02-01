import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/bloc/booking_details_bloc.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(246, 246, 250, 1),
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Colors.white,
            title: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  ref.read(movieProvider).title,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                if (state is BookingDetailsLoaded)
                  Text(
                    "${state.bookingDetails.date}, 2024  |  ${state.bookingDetails.time} Hall 1",
                    style: const TextStyle(
                      color: Color.fromRGBO(97, 195, 242, 1),
                      fontSize: 13,
                    ),
                  ),
                const SizedBox(height: 20)
              ],
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              InteractiveViewer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '\n\n\n  1\n  2\n  3\n  4\n  5\n  6\n  7\n  8\n  9\n  10',
                      style: TextStyle(fontSize: 8.6),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/images/seats.png',
                      height: MediaQuery.of(context).size.width / 2.035,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(30),
                child: Image.asset(
                  'assets/images/seats_icons.png',
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              const Expanded(flex: 3, child: SizedBox()),
              Container(
                padding: const EdgeInsets.all(30),
                height: MediaQuery.of(context).size.width / 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(166, 166, 166, 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Price',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(32, 44, 67, 1),
                            ),
                          ),
                          Text(
                            '\$50',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(32, 44, 67, 1),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(97, 195, 242, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Proceed to pay',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
