import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:study_better/models/tile.dart';
import 'package:study_better/provider/selected_index_provider.dart';
import 'package:study_better/provider/tile_provider.dart';
import 'package:study_better/screens/select_sticker_page.dart';
import 'package:study_better/widgets/app_drawer.dart';
import 'package:study_better/widgets/sticker_tile.dart';

class BoardPage extends StatelessWidget {
  static const routeName = 'board';

  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    late SelectedIndexProvider indexProvider =
        Provider.of<SelectedIndexProvider>(context, listen: false);
    late TileProvider tileProvider =
        Provider.of<TileProvider>(context, listen: false);
    List<Tile> tiles = tileProvider.tiles;
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(backgroundColor: const Color.fromRGBO(255, 211, 163, 1),),
      drawer: const AppDrawer(),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4),
          itemCount: 90,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                indexProvider.setSelectedIndex(index);
                print("index of tile: $index");
                Navigator.of(context)
                    .pushReplacementNamed(SelectStickerPage.routeName);
              },
              child: StickerTile(tileIndex: index),
            );
          }),
    );
  }
}
