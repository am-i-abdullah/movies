import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/models/movie.dart';

var movieProvider = StateProvider<Movie>((ref) => Movie());

void updateMovieProvider(Movie newMovie, WidgetRef ref) {
  ref.read(movieProvider.notifier).state = newMovie;
}
