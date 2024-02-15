import 'package:flutter_test/flutter_test.dart';
import 'package:movies/models/movie.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // group('Testing the fetching movies API call:', () {
  //   const storage = FlutterSecureStorage();

  //   FlutterSecureStorage.setMockInitialValues({
  //     "API_READ_ACCESS_TOKEN":
  //         "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNDc2OWE4OTczMGNkMmQ4YzUwNmE5Y2UzMDQxOWU4MiIsInN1YiI6IjY1Yjk1ZGZkOTBmY2EzMDE0ODA1ZDBjMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eljqy5_yWz28VB8vb6uobi5jODFaGQ8fEVZQgJB65WI",
  //   });

  //   test('Fetch upcoming movies', () async {
  //     List<Movie> movies = await getUpcomingMovies(storage);

  //     expect(movies, isNotEmpty);
  //   });
  // });

  group('Movie.fromJson', () {
    test('should create a Movie instance from a valid JSON map', () {
      final Map<String, dynamic> json = {
        'id': 01,
        'title': '3 idiots',
        'release_date': '2001-02-16',
        'backdrop_path': 'google.jpg',
        'overview': 'amir khan and katrina maybe',
        'genre_ids': [13, 2, 7],
      };

      final Movie movie = Movie.fromJson(json);

      expect(movie.id, equals(01));
      expect(movie.title, equals('3 idiots'));
      expect(movie.releaseDate, equals('2001-02-16'));
      expect(movie.imageURL, equals('google.jpg'));
      expect(movie.overview, equals('amir khan and katrina maybe'));
      expect(movie.genreIDs, equals([13, 2, 7]));
    });

    test('should return a Movie instance with default values if JSON is empty',
        () {
      final Map<String, dynamic> json = {};

      final Movie movie = Movie.fromJson(json);

      expect(movie.id, equals(0));
      expect(movie.genreIDs, isEmpty);
      expect(movie.imageURL, isEmpty);
      expect(movie.title, isEmpty);
      expect(movie.releaseDate, isEmpty);
      expect(movie.overview, isEmpty);
    });
  });
}
