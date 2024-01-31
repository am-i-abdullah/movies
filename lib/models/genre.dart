import 'package:flutter/material.dart';

class Genre {
  final int id;
  final String tag;
  final Color tagColor;
  final String imageURL;

  const Genre({
    required this.id,
    required this.tag,
    required this.tagColor,
    required this.imageURL,
  });
}
