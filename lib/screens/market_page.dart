import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:study_better/widgets/app_drawer.dart';

class MarketPage extends StatelessWidget {
  static const routeName = 'market';
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop Page")),
      drawer: const AppDrawer(),
      body: Text('Shop Page'),
    );
  }
}
