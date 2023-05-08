import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_better/models/sticker.dart';
import 'package:study_better/provider/path_provider.dart';
import 'package:study_better/screens/board_page.dart';
import 'package:study_better/screens/main_page.dart';
import 'package:study_better/screens/market_page.dart';
import 'package:study_better/screens/stickers_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: PathProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
        routes: {
          MarketPage.routeName: (context) => MarketPage(),
          BoardPage.routeName: (context) => BoardPage(),
          MainPage.routeName: (context) => MainPage(),
          StickersGrid.routeName: (context) => StickersGrid(),
        },
      ),
    );
  }
}
