import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:study_better/data/stickers_dummy_data.dart';
import 'package:study_better/provider/sticker_provider.dart';
import 'package:study_better/widgets/app_drawer.dart';

import '../models/sticker.dart';
import '../provider/jwt_provider.dart';
import '../widgets/sticker_card.dart';

class MarketPage extends StatelessWidget {
  static const routeName = 'shop';

  const MarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late JwtProvider jwtProvider = Provider.of<JwtProvider>(context, listen: false);
    List<Sticker> allStickers = Provider.of<StickerProvider>(context).stickers;
    List<Sticker> stickers = allStickers.where((sticker) => !sticker.usable).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 211, 163, 1),
        actions: [
          FutureBuilder<Object>(
            future: fetchCoinAmount(jwtProvider.jwt),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final coinAmount = snapshot.data ?? 0;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_money), // Coin icon
                      const SizedBox(width: 4),
                      Text(
                        coinAmount.toString(),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Container(
        color: const Color.fromRGBO(252, 255, 178, 0.8), // Set the overall background color
        padding: const EdgeInsets.all(16.0), // Add padding around the list
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < stickers.length; i += 2)
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: StickerCard(sticker: stickers[i]),
                      ),
                    ),
                    if (i + 1 < stickers.length)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: StickerCard(sticker: stickers[i + 1]),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Object> fetchCoinAmount(token) async {
    try{
      final url = Uri.parse('http://192.168.1.20:8080/studybetter-api/v0/user/coins');
      final headers = {"Content-type": "application/json", 'Authorization': 'Bearer $token'};
      Response response = await get(url, headers: headers);
      print(response.body);
      return response.body;
    } catch (e){
      print("error occured: $e");
      return 0;
    }
  }

}
