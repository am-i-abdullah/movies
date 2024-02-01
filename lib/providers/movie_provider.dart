import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/models/movie.dart';

final movieProvider = StateProvider<Movie>((ref) => Movie());
