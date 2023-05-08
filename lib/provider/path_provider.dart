import 'package:flutter/material.dart';

import '../data/stickers_data.dart';

class PathProvider extends ChangeNotifier {
  String _path = stickers.first.path;

  String get path => _path;

  void setPath(String newPath) {
    _path = newPath;
    notifyListeners();
  }
}
