import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/bloc/booking_details_bloc.dart';
import 'package:movies/bloc/movies_bloc.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/utils/color_pallete.dart';

final theme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(),
  colorScheme: colorPallete,
);

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BookingDetailsBloc>(
          create: (context) => BookingDetailsBloc(),
        ),
        BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc(),
        ),
      ],
      child: const ProviderScope(
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Movies',
      home: const MainScreen(),
    );
  }
}
