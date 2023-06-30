import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../provider/path_provider.dart';
import '../screens/main_page.dart';
import './sticker.dart';

class StickerGridItem extends StatelessWidget {
  const StickerGridItem({super.key, required this.sticker});

  final Sticker sticker;

  @override
  Widget build(BuildContext context) {
    late PathProvider pathProvider =
        Provider.of<PathProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (sticker.usable == false) {
        } else {
          print(sticker.id);
          pathProvider.setPath(sticker.path);
          Navigator.of(context).pushReplacementNamed(MainPage.routeName);
        }
      },
      child: sticker.usable
          ? Image.asset(sticker.path)
          : Image.asset(sticker.path).blurred(blur: 3),
    );
  }
}
