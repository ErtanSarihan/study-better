import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:study_better/widgets/app_drawer.dart';

class BoardPage extends StatelessWidget {
  static const routeName = 'board';
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board Page'),
      ),
      drawer: AppDrawer(),
      body: Text('Board Page'),
    );
  }
}
