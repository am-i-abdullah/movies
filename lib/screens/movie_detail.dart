import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/utils/date_formatter.dart';
import 'package:movies/widget/genres_list.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 250, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('Watch'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              // background image
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.7,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie.imageURL}',
                  fit: BoxFit.cover,
                ),
              ),

              // foregroud objects
              Positioned.fill(
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    Text(
                      'In Theaters: ${formatDate(movie.releaseDate)}',
                      style: textStyle,
                    ),
                    const SizedBox(height: 10),

                    // Get Tickets button, navigate to ticketing screen
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(97, 195, 242, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width / 1.55,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Get Tickets',
                          style: textStyle,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    // watch trailer button, play trailer in pop-up
                    Container(
                      width: MediaQuery.of(context).size.width / 1.55,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: const Color.fromRGBO(97, 195, 242, 1),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            Text(
                              ' Watch Trailer',
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                // genre tags
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Genres    ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(32, 44, 67, 1),
                    ),
                  ),
                ),
                GenresList(ids: movie.genreIDs),
                const SizedBox(height: 15),
                // overview

                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(32, 44, 67, 1),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Text(
                    movie.overview,
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromRGBO(143, 143, 143, 1),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
