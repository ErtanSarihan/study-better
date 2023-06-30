import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_better/models/sticker.dart';
import 'package:study_better/provider/jwt_provider.dart';
import 'package:study_better/provider/path_provider.dart';
import 'package:study_better/provider/selected_index_provider.dart';
import 'package:study_better/provider/tile_provider.dart';
import 'package:study_better/screens/board_page.dart';
import 'package:study_better/screens/leaderboard_page.dart';
import 'package:study_better/screens/login_page.dart';
import 'package:study_better/screens/main_page.dart';
import 'package:study_better/screens/market_page.dart';
import 'package:study_better/screens/register_page.dart';
import 'package:study_better/screens/select_sticker_page.dart';
import 'package:study_better/screens/sessions_page.dart';
import 'package:study_better/screens/stickers_grid.dart';
import 'package:study_better/utils/local_storage.dart';
import 'package:study_better/provider/sticker_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.init();
  runApp(const MyApp());
  EquatableConfig.stringify = true;
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
        ChangeNotifierProvider.value(
          value: StickerProvider()..init(),
        ),
        ChangeNotifierProvider.value(
          value: SelectedIndexProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TileProvider()..init(),
        ),
        ChangeNotifierProvider.value(
          value: JwtProvider()..init(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const LoginPage(),
        home: FutureBuilder<String>(
          future: LocalStorage.getJWT(),
            builder: (
                BuildContext context,
                AsyncSnapshot<String> snapshot,
                ) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData && (snapshot.data != "")) {
                  print("data: ${snapshot.data}");
                  return const MainPage();
                } else {
                  return const LoginPage();
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
        ),
        routes: {
          MarketPage.routeName: (context) => MarketPage(),
          BoardPage.routeName: (context) => BoardPage(),
          MainPage.routeName: (context) => MainPage(),
          StickersGrid.routeName: (context) => StickersGrid(),
          SelectStickerPage.routeName: (context) => SelectStickerPage(),
          RegisterPage.routeName: (context) => RegisterPage(),
          LoginPage.routeName: (context) => LoginPage(),
          SessionsPage.routeName: (context) => SessionsPage(),
          LeaderboardPage.routeName: (context) => LeaderboardPage(),
        },
      ),
    );
  }
}
