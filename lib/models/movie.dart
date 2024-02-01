import 'package:hive_flutter/hive_flutter.dart';

part 'movie.g.dart';

@HiveType(typeId: 1)
class Movie {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String releaseDate;
  @HiveField(3)
  late String imageURL;
  @HiveField(4)
  late String overview;
  @HiveField(5)
  late List<int> genreIDs;

  Movie() {
    id = 0;
    title = '';
    releaseDate = '';
    imageURL = '';
    overview = '';
    genreIDs = [];
  }
}
