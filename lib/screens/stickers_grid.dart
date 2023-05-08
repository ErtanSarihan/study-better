import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:study_better/models/sticker_item.dart';

import '../widgets/app_drawer.dart';
import '../data/stickers_data.dart';

class StickersGrid extends StatelessWidget {
  const StickersGrid({super.key});
  static const routeName = 'stickers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select your reward before session!")),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final sticker in stickers) StickerGridItem(sticker: sticker),
        ],
      ),
    );
  }
}
