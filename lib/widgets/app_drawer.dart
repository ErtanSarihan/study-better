import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:study_better/screens/board_page.dart';
import 'package:study_better/screens/leaderboard_page.dart';
import 'package:study_better/screens/login_page.dart';

import '../screens/market_page.dart';
import '../screens/main_page.dart';
import '../screens/sessions_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(252, 255, 178, 0.8),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color.fromRGBO(255, 85, 187, 0.4)),
            child: Image.asset('assets/images/logo.png'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Main Page"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MainPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Shop Page"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MarketPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.rectangle),
            title: const Text("Board Page"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(BoardPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("User Statistics Page"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(SessionsPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.leaderboard),
            title: const Text("Leaderboard Page"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LeaderboardPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              // jwt yi sil
              // userla ilgili dataları temizle
              Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
            },
          )
        ],
      ),
    );
  }
}
