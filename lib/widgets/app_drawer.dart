import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:study_better/screens/board_page.dart';

import '../screens/market_page.dart';
import '../screens/main_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Study Better!!!"),
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
          )
        ],
      ),
    );
  }
}
