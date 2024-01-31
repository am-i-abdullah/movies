class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final String imageURL;
  final String overview;
  final List<int> genreIDs;

  const Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.imageURL,
    required this.genreIDs,
    required this.overview,
  });
}
