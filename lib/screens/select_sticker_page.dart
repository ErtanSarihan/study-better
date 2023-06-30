import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_better/models/sticker.dart';
import 'package:study_better/models/tile.dart';
import 'package:study_better/provider/selected_index_provider.dart';
import 'package:study_better/provider/tile_provider.dart';
import 'package:study_better/screens/board_page.dart';

import '../provider/sticker_provider.dart';
import '../widgets/app_drawer.dart';

class SelectStickerPage extends StatelessWidget {
  static const routeName = 'selectSticker';

  const SelectStickerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late StickerProvider stickerProvider =
        Provider.of<StickerProvider>(context);
    late SelectedIndexProvider indexProvider =
        Provider.of<SelectedIndexProvider>(context);
    late TileProvider tileProvider = Provider.of<TileProvider>(context);
    int selectedIndex = indexProvider.selectedIndex;
    List<Tile> tiles = tileProvider.tiles;
    List<Sticker> stickers = stickerProvider.stickers;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 211, 163, 1),
      ),
      drawer: const AppDrawer(),
      body: Container(
        color: const Color.fromRGBO(252, 255, 178, 0.8),
        child: GridView.count(
          crossAxisCount: 4,
          children: stickers
              .map((sticker) => GestureDetector(
                    onTap: () {
                      if (sticker.usable &&
                          sticker.ownedAmount > 0 &&
                          (sticker.ownedAmount > sticker.usedAmount)) {
                        Tile tempTile =
                            Tile(index: selectedIndex, path: sticker.path);
                        String deletedPath = tileProvider.addTile(tempTile);
                        deletedPath != "empty"
                            ? stickerProvider.decrementUsedAmount(deletedPath)
                            : () {};
                        stickerProvider.incrementUsedAmount(sticker.path);
                        Navigator.of(context)
                            .pushReplacementNamed(BoardPage.routeName);
                      } else {}
                    },
                    child: Stack(
                      children: <Widget>[
                        (sticker.usable &&
                                sticker.ownedAmount > 0 &&
                                (sticker.ownedAmount > sticker.usedAmount))
                            ? Image.asset(sticker.path)
                            : Image.asset(sticker.path).blurred(blur: 3),
                        (sticker.usable &&
                                sticker.ownedAmount > 0 &&
                                (sticker.ownedAmount > sticker.usedAmount))
                            ? const Text("usable")
                            : const Text("not usable")
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
