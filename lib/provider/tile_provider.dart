import 'package:flutter/material.dart';
import 'package:study_better/models/tile.dart';
import 'package:study_better/provider/sticker_provider.dart';
import 'package:study_better/utils/local_storage.dart';

import '../data/stickers_dummy_data.dart';
import '../utils/local_storage.dart';

class TileProvider extends ChangeNotifier {
  List<Tile> _tiles = [];

  List<Tile> get tiles => _tiles;

  void init() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Tile>? tempTiles = LocalStorage.getTiles();
    if (tempTiles == null) {
      LocalStorage.saveTiles(tiles: _tiles);
    } else {
      _tiles = tempTiles;
    }
  }

  void setTiles(List<Tile> tiles){
    _tiles = tiles;
    LocalStorage.saveTiles(tiles: _tiles);
    notifyListeners();
  }

  String addTile(Tile tileToAdd){
    var contain = _tiles.where((tile) => tile.index == tileToAdd.index);
    if(contain.isEmpty){
      _tiles.add(tileToAdd);
      LocalStorage.saveTiles(tiles: _tiles);
      notifyListeners();
      return "empty";
    } else{
      int index = _tiles.indexWhere((element) => element.index == tileToAdd.index);
      final Tile tile = _tiles[index];
      String path = tile.path;
      _tiles[index] = tile.copyWith(tileToAdd.path);
      notifyListeners();
      LocalStorage.saveTiles(tiles: _tiles);
      return path;
    }
  }

}
