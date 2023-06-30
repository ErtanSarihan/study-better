import 'package:flutter/material.dart';

class Tile {
  late final int index;
  late final String path;

  Tile({
    required this.index,
    required this.path,
  });


  Tile copyWith(String pathToReplace){
    return Tile(index: index, path: pathToReplace);
  }

  static Map<String, dynamic> toJson(Tile tile) {
    return {
      "index": tile.index,
      "path": tile.path
    };
  }

  factory Tile.fromJson(Map<String, dynamic> jsonData) {
    return Tile(
      index: jsonData['index'],
      path: jsonData['path'],
    );
  }

}
