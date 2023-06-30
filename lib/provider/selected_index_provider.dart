import 'package:flutter/material.dart';
import 'package:study_better/provider/sticker_provider.dart';

import '../data/stickers_dummy_data.dart';

class SelectedIndexProvider extends ChangeNotifier {
  late int _selectedIndex;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int newSelectedIndex) {
    _selectedIndex = newSelectedIndex;
    notifyListeners();
  }

}
