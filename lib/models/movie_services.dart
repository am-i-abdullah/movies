import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/models/movie.dart';

class MovieService {
  final String _boxName = 'MoviesBox';

  Future<Box<Movie>> get _box async {
    return await Hive.openBox<Movie>(_boxName);
  }

  Future<void> addMovies(List<Movie> movies) async {
    var box = await _box;

    await box.addAll(movies);
  }

  Future<List<Movie>> getMovies() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deleteAll() async {
    var box = await _box;
    await box.clear();
  }
}
