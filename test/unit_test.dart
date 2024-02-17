import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/models/movie.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  Dio dio = Dio(BaseOptions());
  DioAdapter dioAdapter = DioAdapter(dio: dio);
  Response<dynamic> response;

  await dotenv.load(fileName: ".env");
  String apiReadAccessToken = dotenv.env['API_READ_ACCESS_TOKEN']!;

  final Map<String, String> headers = {
    'Authorization': 'Bearer $apiReadAccessToken',
    'accept': 'application/json',
  };

  group('Testing the fetching movies API call:', () {
    setUp(() {
      dioAdapter.onGet(
        'https://api.themoviedb.org/3/movie/upcoming',
        (server) => server.reply(
          200,
          {'message': 'successful'},
          // Delay the response by 1 second
          delay: const Duration(seconds: 1),
        ),
      );
    });

    test('Fetch upcoming movies', () async {
      response = await dio.get(
        'https://api.themoviedb.org/3/movie/upcoming',
        options: Options(headers: headers),
      );
      expect(response.statusCode, 200);
    });

    // for movie trailer link
    setUp(() {
      dioAdapter.onGet(
        'https://api.themoviedb.org/3/movie/634492/videos?language=en-US',
        (server) => server.reply(
          200,
          {'message': 'successful'},
          // Delay the response by 1 second
          delay: const Duration(seconds: 1),
        ),
      );
    });

    test('Fetch Trailer Link API Call', () async {
      response = await dio.get(
        'https://api.themoviedb.org/3/movie/634492/videos?language=en-US',
        options: Options(headers: headers),
      );
      expect(response.statusCode, 200);
    });
  });

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
