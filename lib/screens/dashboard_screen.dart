import 'package:flutter/material.dart';
import 'package:movies/bloc/movies_bloc.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/movie/movie_detail.dart';
import 'package:movies/widget/item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Movie> movies = [];
  Widget content = const SizedBox();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // loading data in start of application
    context.read<MoviesBloc>().add(LoadMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 250, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromRGBO(32, 44, 67, 1),
        title: const Text(
          'Watch',
          style: TextStyle(
            color: Color.fromRGBO(32, 44, 67, 1),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocConsumer<MoviesBloc, MoviesState>(
        listener: (context, state) {
          // set to loading widget
          if (state is MoviesLoading) {
            content = const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(130, 125, 136, 1),
              ),
            );
          }
          // incase of anything wrong...
          if (state is MoviesLoadingFailed) {
            content = ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Column(
                    children: [
                      const Expanded(child: SizedBox()),
                      Center(
                        child: Image.asset(
                          'assets/no_internet.png',
                          height: 100,
                        ),
                      ),
                      const Text('Something went wrong!'),
                    ],
                  ),
                );
              },
            );
          }
          // got movies data from internet or local storage
          if (state is MoviesLoaded) {
            movies = state.movies;
            content = ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: movies.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return InkWell(
                  // using provider, for using Move instance data in other screens
                  onTap: () {
                    updateMovieProvider(movies[index]);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const MovieDetails();
                      }),
                    );
                  },

                  // card content
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ItemCard(
                      imageURL:
                          'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movies[index].imageURL}',
                      title: movies[index].title,
                    ),
                  ),
                );
              },
            );
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            color: Colors.white,
            backgroundColor: const Color.fromRGBO(130, 125, 136, 1),

            // reloading data from internet
            onRefresh: () async {
              context.read<MoviesBloc>().add(DeleteMoviesEvent());
              context.read<MoviesBloc>().add(LoadMoviesEvent());
            },
            child: content,
          );
        },
      ),
    );
  }
}
