import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, required this.imageURL, required this.title});
  final String imageURL;
  final String title;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(
              widget.imageURL,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
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
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                // Show an error widget if loading fails
                return Container(
                    padding: const EdgeInsets.all(10),
                    child: ErrorWidget('Something went wrong!'));
              },
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              widget.title,
              // maxLines: 1,
              // softWrap: false,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
