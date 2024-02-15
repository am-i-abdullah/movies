import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/data/genres.dart';
import 'package:movies/providers/query_provider.dart';
import 'package:movies/widget/item_card.dart';
import 'package:movies/widget/search_results.dart';

class WatchScreen extends ConsumerStatefulWidget {
  const WatchScreen({super.key});

  @override
  ConsumerState<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends ConsumerState<WatchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(queryProvider)['query'];

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(246, 246, 250, 1),
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),

          // search bar
          title: TextField(
            controller: searchController,
            onSubmitted: (value) {
              ref.read(queryProvider.notifier).setShowResults(true);
            },
            onChanged: (value) {
              ref.read(queryProvider.notifier).setShowResults(false);
              ref
                  .read(queryProvider.notifier)
                  .updateQuery(searchController.text);
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              hintText: 'TV shows, movies and more',
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.5,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),

              // done search query
              prefixIcon: Container(
                margin: const EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    ref.read(queryProvider.notifier).setShowResults(true);
                  },
                  color: const Color.fromRGBO(32, 44, 67, 1),
                ),
              ),

              // clear the all search results
              suffixIcon: Container(
                margin: const EdgeInsets.only(right: 7),
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Color.fromRGBO(32, 44, 67, 1),
                  ),
                  onPressed: () {
                    ref.read(queryProvider.notifier).setShowResults(false);
                    ref.read(queryProvider.notifier).updateQuery("");
                    searchController.clear();
                  },
                ),
              ),
              filled: true,
              fillColor: const Color.fromRGBO(239, 239, 239, 1),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),

        // searched items or all genres
        body: query != ""
            ? const SearchResults()
            : GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.63,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    imageURL: genres[index].imageURL,
                    title: genres[index].tag,
                  );
                },
              ),
      ),
    );
  }
}
