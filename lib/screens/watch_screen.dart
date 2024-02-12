import 'package:flutter/material.dart';
import 'package:movies/data/genres.dart';
import 'package:movies/widget/item_card.dart';
import 'package:movies/widget/search_results.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  TextEditingController searchController = TextEditingController();
  bool searchingDone = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(246, 246, 250, 1),
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),

          // search bar
          title: TextField(
            controller: searchController,
            onSubmitted: (value) {},
            onChanged: (value) {
              setState(() {
                searchingDone = false;
              });
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
                    setState(() {
                      searchingDone = true;
                    });
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
                    setState(() {
                      searchController.clear();
                    });
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
        body: searchController.text.isEmpty
            ? GridView.builder(
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
              )
            : SearchResults(
                query: searchController.text,
                searchingDone: searchingDone,
              ),
      ),
    );
  }
}
