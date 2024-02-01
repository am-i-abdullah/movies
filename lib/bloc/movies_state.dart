part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

// app just started
final class MoviesInitial extends MoviesState {}

// fetching data from internet or reading from local stroage
final class MoviesLoading extends MoviesState {}

// after successful fetching or reading
final class MoviesLoaded extends MoviesState {
  final List<Movie> movies;

  MoviesLoaded({required this.movies});
}

// some error e.g. poor internet, etc
final class MoviesLoadingFailed extends MoviesState {}
