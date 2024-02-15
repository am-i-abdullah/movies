import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:movies/models/movie.dart';

Future<List<Movie>> getUpcomingMovies(FlutterSecureStorage storage) async {
  String? apiReadAccessToken = await storage.read(key: 'API_READ_ACCESS_TOKEN');

  final Dio dio = Dio();

  const String endpoint = 'https://api.themoviedb.org/3/movie/upcoming';

  final Map<String, String> headers = {
    'Authorization': 'Bearer $apiReadAccessToken',
    'accept': 'application/json',
  };

  final Response res;

  try {
    res = await dio.get(
      endpoint,
      options: Options(
        headers: headers,
      ),
    );

    List<Movie> movies = [];

    final data = res.data['results'] as List<dynamic>;

    // converting json to movies objects
    movies = data.map((movie) => Movie.fromJson(movie)).toList();

    // sorting all upcoming movies by date (ascending)
    movies.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
    return movies;
  } catch (error) {
    return [];
  }
}
