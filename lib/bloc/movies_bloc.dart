import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/api/get_upcoming_movies.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movie_services.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<LoadMoviesEvent>((event, emit) async {
      emit(MoviesLoading());
      await Future.delayed(const Duration(seconds: 1));

      try {
        MovieService movieService = MovieService();

        List<Movie> savedMovies = await movieService.getMovies();

        // incase there's no saved movies in local storage, then load from API
        if (savedMovies.isEmpty) {
          List<Movie> upcomingMovies = await getUpcomingMovies();
          // incase of poor internet connection, or any kind of exception
          if (upcomingMovies.isEmpty) {
            return emit(MoviesLoadingFailed());
          }

          // saving movies data locally
          await movieService.addMovies(upcomingMovies);

          // update the application status
          return emit(MoviesLoaded(movies: upcomingMovies));
        }
        // incase there's movies data in local storage
        else {
          return emit(MoviesLoaded(movies: savedMovies));
        }
      } catch (error) {
        // if anything goes wrong, can be managed further,
        // for multiple kinds of exceptions hanlding
        emit(MoviesLoadingFailed());
      }
    });

    on<DeleteMoviesEvent>((event, emit) async {
      // clearing local storage
      MovieService movieService = MovieService();
      await movieService.deleteAll();
    });
  }
}
