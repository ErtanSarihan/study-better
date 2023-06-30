import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:study_better/data/stickers_dummy_data.dart';
import 'package:study_better/provider/sticker_provider.dart';

import '../models/sticker.dart';
import '../provider/jwt_provider.dart';

class StickerCard extends StatefulWidget {
  final Sticker sticker;

  const StickerCard({Key? key, required this.sticker}) : super(key: key);

  @override
  State<StickerCard> createState() => _StickerCardState();
}

class _StickerCardState extends State<StickerCard> {
  late JwtProvider jwtProvider =
      Provider.of<JwtProvider>(context, listen: false);
  late StickerProvider stickerProvider =
      Provider.of<StickerProvider>(context, listen: false);

  void responseHandler(isSuccessful) {
    if (isSuccessful == "true") {
      widget.sticker.usable = true;
      List<Sticker> stickers = stickerProvider.stickers;
      int index =
          stickers.indexWhere((sticker) => sticker.path == widget.sticker.path);
      if (index != -1) {
        stickers[index] = widget.sticker;
        stickerProvider.setStickers(stickers);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[400], // Set the background color
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Confirmation'),
                content: const Text('Do you want to buy the sticker?'),
                actions: [
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close the dialog
                    },
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () async {
                      try {
                        final token = jwtProvider.jwt;
                        final url = Uri.parse(
                            'http://192.168.1.20:8080/studybetter-api/v0/user/coins/50');
                        final headers = {
                          "Content-type": "application/json",
                          'Authorization': 'Bearer $token'
                        };
                        final response = await post(url, headers: headers);
                        print(response.body);
                        responseHandler(response.body);
                        Navigator.of(dialogContext).pop();
                      } catch (e) {
                        print("error occurred: $e");
                      }
                    },
                  ),
                ],
              );
            },
          );
          print('Card tapped!');
        },
        child: Card(
          elevation: 0,
          // Remove card elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.transparent,
          // Set card background color to transparent
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.sticker.path,
                  height: 150,
                  width: 150,
                  alignment: FractionalOffset
                      .center, // Center the image within the card
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cost: 50',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
