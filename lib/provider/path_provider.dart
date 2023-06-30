import 'package:flutter/material.dart';
import 'package:study_better/provider/sticker_provider.dart';

import '../data/stickers_dummy_data.dart';

class PathProvider extends ChangeNotifier {
  String _path = dummyStickers.first.path;

  String get path => _path;

  void setPath(String newPath) {
    _path = newPath;
    notifyListeners();
  }

}
