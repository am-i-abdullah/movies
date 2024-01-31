import 'package:flutter/material.dart';
import 'package:movies/data/genres.dart';
import 'package:movies/models/genre.dart';

class GenresList extends StatelessWidget {
  const GenresList({super.key, required this.ids});
  final List<int> ids;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        itemCount: ids.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          Genre? gen = genres.firstWhere(
            (element) => element.id == ids[index],
            orElse: () => const Genre(
                id: 0, tag: 'tag', tagColor: Colors.black, imageURL: ''),
          );

          if (gen.id == 0) {
            return null;
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.only(right: 5),
            height: 25,
            decoration: BoxDecoration(
              color: gen.tagColor,
              borderRadius: BorderRadius.circular(12.5),
            ),
            child: Center(
              child: Text(
                gen.tag,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
