import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/bloc/movies_bloc.dart';
import 'package:movies/data/genres.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/movie/movie_detail.dart';
import 'package:movies/widget/item_card.dart';

class SearchResults extends ConsumerStatefulWidget {
  const SearchResults({super.key, required this.query});

  final String query;

  @override
  ConsumerState<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends ConsumerState<SearchResults> {
  List<Movie> filteredMovies = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoaded) {
          filteredMovies = state.movies
              .where((movie) => movie.title
                  .toLowerCase()
                  .contains(widget.query.toLowerCase()))
              .toList();
        }
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: filteredMovies.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // navigate to movie detials screen
                ref.read(movieProvider).id = filteredMovies[index].id;
                ref.read(movieProvider).title = filteredMovies[index].title;
                ref.read(movieProvider).releaseDate =
                    filteredMovies[index].releaseDate;
                ref.read(movieProvider).imageURL =
                    filteredMovies[index].imageURL;
                ref.read(movieProvider).genreIDs =
                    filteredMovies[index].genreIDs;
                ref.read(movieProvider).overview =
                    filteredMovies[index].overview;

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const MovieDetails();
                  }),
                );
              },
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.35,
                    height: MediaQuery.of(context).size.height / 7,
                    padding: const EdgeInsets.all(5),
                    child: ItemCard(
                        imageURL:
                            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${filteredMovies[index].imageURL}',
                        title: ''),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          filteredMovies[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          genres
                              .firstWhere((element) =>
                                  element.id ==
                                  filteredMovies[index].genreIDs[0])
                              .tag,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(219, 219, 223, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),

                  // navigate to movie details screen
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Color.fromRGBO(97, 195, 242, 1),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
