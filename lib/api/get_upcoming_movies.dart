import 'package:dio/dio.dart';
import 'package:movies/api/api_credentials.dart';
import 'package:movies/models/movie.dart';

Future<List<Movie>> getUpcomingMovies() async {
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

    for (final movie in res.data['results']) {
      Movie mov = Movie();
      mov.genreIDs = List<int>.from(movie['genre_ids']);
      mov.id = movie['id'];
      mov.imageURL = movie['backdrop_path'];
      mov.overview = movie['overview'];
      mov.title = movie['title'];
      mov.releaseDate = movie['release_date'];

      movies.add(mov);
    }
    movies.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));

    return movies;
  } catch (error) {
    return [];
  }
}
