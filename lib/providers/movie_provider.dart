import 'package:movies/models/movie.dart';

var movieProvider = Movie();

void updateMovieProvider(Movie newMovie) {
  movieProvider = newMovie;
}
