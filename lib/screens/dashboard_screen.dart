import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movies/api/api_credentials.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/movie_detail.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final Dio dio = Dio();

    const String endpoint = 'https://api.themoviedb.org/3/movie/upcoming';

    final Map<String, String> headers = {
      'Authorization': 'Bearer $apiReadAccessToken',
      'accept': 'application/json',
    };

    final Response res = await dio.get(
      endpoint,
      options: Options(
        headers: headers,
      ),
    );
    setState(() {
      movies = res.data['results'];
      print(movies[2]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 250, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Watch'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: movies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(130, 125, 136, 1),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: movies.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Movie movie = Movie(
                      id: movies[index]['id'],
                      title: movies[index]['title'],
                      releaseDate: movies[index]['release_date'],
                      imageURL: movies[index]['backdrop_path'],
                      genreIDs: List<int>.from(movies[index]['genre_ids']),
                      overview: movies[index]['overview'],
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return MovieDetails(movie: movie);
                      }),
                    );
                  },

                  // card content
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movies[index]['backdrop_path']}',
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // If the image is loaded, display it
                                } else {
                                  return Shimmer.fromColors(
                                    direction: ShimmerDirection.btt,
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      color: Colors.amber,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              movies[index]['title'],
                              // maxLines: 1,
                              // softWrap: false,
                              // overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
