import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:study_better/utils/local_storage.dart';

import '../models/sticker.dart';
import '../data/stickers_dummy_data.dart';

class StickerProvider with ChangeNotifier {
  List<Sticker> _stickers = [];

  void init() async {
    await Future.delayed(const Duration(seconds: 1));
    List<Sticker>? tempStickers = LocalStorage.getStickers();
    if (tempStickers == null) {
      _stickers = dummyStickers;
      LocalStorage.saveStickers(stickers: _stickers);
    } else {
      _stickers = tempStickers;
    }
  }

  void setStickers(List<Sticker> stickers) {
    _stickers = stickers;
    LocalStorage.saveStickers(stickers: _stickers);
    notifyListeners();
  }

  List<Sticker> get stickers => _stickers;

  void incrementOwnedAmount(String id) {
    final int index = _stickers.indexWhere((element) => element.id == id);
    final Sticker sticker = _stickers[index];
    _stickers[index] = sticker.copyWithOwnedAmount(sticker.ownedAmount + 1);
    notifyListeners();
    LocalStorage.saveStickers(stickers: _stickers);
  }

  void decrementUsedAmount(String pathOfDeleted) {
    final int index =
        _stickers.indexWhere((element) => element.path == pathOfDeleted);
    final Sticker sticker = _stickers[index];
    _stickers[index] = sticker.copyWithUsedAmount(sticker.usedAmount - 1);
    print("decrementUsedAmount path: $pathOfDeleted");
    notifyListeners();
    LocalStorage.saveStickers(stickers: _stickers);
  }

  void incrementUsedAmount(String pathOfAdded) {
    final int index =
        _stickers.indexWhere((element) => element.path == pathOfAdded);
    final Sticker sticker = _stickers[index];
    _stickers[index] = sticker.copyWithUsedAmount(sticker.usedAmount + 1);
    print("incrementUsedAmount path: $pathOfAdded");
    notifyListeners();
    LocalStorage.saveStickers(stickers: _stickers);
  }
}
