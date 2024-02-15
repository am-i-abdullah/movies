import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> getTrailerVideoKey(String id) async {
  String? apiReadAccessToken =
      await const FlutterSecureStorage().read(key: 'API_READ_ACCESS_TOKEN');

  final Dio dio = Dio();

  String endpoint =
      'https://api.themoviedb.org/3/movie/$id/videos?language=en-US';

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

    for (final result in res.data['results']) {
      if (result['type'] == "Trailer" &&
          result['official'] &&
          result['site'] == 'YouTube') {
        return result['key'];
      }
    }

    return res.data['results'][0]['key'];
  } catch (error) {
    return '';
  }
}
