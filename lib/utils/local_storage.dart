import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_better/data/stickers_dummy_data.dart';

import '../models/sticker.dart';
import '../models/tile.dart';

const STICKER_KEY = "STICKERS";
const TILE_KEY = "TILES";
const JWT_KEY = "JWT";

class LocalStorage {
  static late SharedPreferences _sharedPreferences;

  static void init() async {
    print("started init local storage");
    _sharedPreferences = await SharedPreferences.getInstance();
    print("ended init local storage");
  }

  static List<Sticker>? getStickers() {
    try {
      String? value = _sharedPreferences.getString(STICKER_KEY);
      if (value == null) {
        print("initialize stickers");
        saveStickers(stickers: dummyStickers);
        return dummyStickers;
      }
      return decode(value);
    } catch (e) {
      print("get stickers failed error: $e");
      return null;
    }
  }

  static bool saveStickers({required List<Sticker> stickers}) {
    try {
      _sharedPreferences.setString(STICKER_KEY, encode(stickers));
      return true;
    } catch (e) {
      print("save stickers failed error: $e");
      return false;
    }
  }

  static bool saveTiles({required List<Tile> tiles}) {
    try {
      _sharedPreferences.setString(TILE_KEY, encodeTiles(tiles));
      return true;
    } catch (e) {
      print("save tiles failed error: $e");
      return false;
    }
  }

  static List<Tile>? getTiles() {
    try {
      String? value = _sharedPreferences.getString(TILE_KEY);
      if (value == null) {
        print("initialize tiles");
        saveTiles(tiles: []);
        return [];
      }
      return decodeTiles(value);
    } catch (e) {
      print("get tiles failed error: $e");
      return null;
    }
  }

  static bool saveJWT({required String jwtToSave}) {
    try {
      _sharedPreferences.setString(JWT_KEY, jwtToSave);
      return true;
    } catch (e) {
      print("save jwt failed error: $e");
      return false;
    }
  }

  static Future<String> getJWT() {
    try {
      String? value = _sharedPreferences.getString(JWT_KEY);
      if (value != null) {
        if(value.isNotEmpty){
          return Future.delayed(const Duration(seconds: 1), () => value);
        }
        Future.delayed(const Duration(seconds: 1), () => "");
      } else {
        Future.delayed(const Duration(seconds: 1), () => "");
      }
    } catch (e) {
      print("get jwt failed error: $e");
      return Future.delayed(const Duration(seconds: 1), () => "");
    }
    return Future.delayed(const Duration(seconds: 1), () => "");
  }

  static String encode(List<Sticker> stickers) {
    return json.encode(stickers
        .map<Map<String, dynamic>>((sticker) => Sticker.toJson(sticker))
        .toList());
  }

  static List<Sticker> decode(String? stickers) {
    return (json.decode(stickers!) as List<dynamic>)
        .map<Sticker>((sticker) => Sticker.fromJson(sticker))
        .toList();
  }

  static String encodeTiles(List<Tile> tiles) {
    return json.encode(
        tiles.map<Map<String, dynamic>>((tile) => Tile.toJson(tile)).toList());
  }

  static List<Tile> decodeTiles(String? tiles) {
    return (json.decode(tiles!) as List<dynamic>)
        .map<Tile>((tile) => Tile.fromJson(tile))
        .toList();
  }

//yeni obje tipini get,save,encode,decode yazılması lazım

//loadTiles--saveTiles--encodeTiles--decodeTiles
}
