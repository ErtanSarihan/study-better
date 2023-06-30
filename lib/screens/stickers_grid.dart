import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:study_better/models/sticker.dart';
import 'package:study_better/models/sticker_item.dart';
import 'package:study_better/provider/sticker_provider.dart';

import '../widgets/app_drawer.dart';
import '../data/stickers_dummy_data.dart';

class StickersGrid extends StatelessWidget {
  const StickersGrid({super.key});

  static const routeName = 'stickers';

  @override
  Widget build(BuildContext context) {
    late StickerProvider stickerData = Provider.of<StickerProvider>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromRGBO(255, 211, 163, 1),),
      drawer: const AppDrawer(),
      body: Container(
        color: const Color.fromRGBO(252, 255, 178, 0.8),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            for (final sticker in stickerData.stickers!)
              StickerGridItem(sticker: sticker),
          ],
        ),
      ),
    );
  }
}
