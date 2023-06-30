import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_better/provider/tile_provider.dart';

import '../models/tile.dart';

class StickerTile extends StatelessWidget {
  final int tileIndex;

  const StickerTile({Key? key, required this.tileIndex}) : super(key: key);

  // sticker path

  @override
  Widget build(BuildContext context) {
    late TileProvider tileProvider = Provider.of<TileProvider>(context);
    List<Tile> tiles = tileProvider.tiles;
    bool indexExists = tiles.any((tile) => tile.index == tileIndex);
    if (indexExists) {
    int index = tiles.indexWhere((tile) => tile.index == tileIndex);
      return (Card(
        color: const Color.fromRGBO(252, 255, 178, 0.8),
          child: Center(
        child: Image.asset(
          tiles[index].path,
          height: 150,
          width: 150,
        ),
      )));
    } else {
      return Card(
        color: Colors.primaries[tileIndex % 10],
        child: const Center(
          child: Text(""),
        ),
      );
    }
  }
}
