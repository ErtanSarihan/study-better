import 'dart:async';
import 'dart:io';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_better/provider/path_provider.dart';
import 'package:study_better/screens/market_page.dart';
import 'package:study_better/screens/stickers_grid.dart';
import 'package:study_better/widgets/app_drawer.dart';
import 'package:study_better/widgets/time_picker.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  static const routeName = 'main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Duration _duration = const Duration(hours: 0, minutes: 5);
  late Timer _timer;
  bool _isCountdownActive = false;
  late PathProvider _pathProvider = Provider.of<PathProvider>(context);

  void startCountdown() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_duration == oneSec) {
        setState(() {
          timer.cancel();
          _isCountdownActive = false;
        });
      } else {
        setState(() {
          _isCountdownActive = true;
          _duration = _duration - oneSec;
          print(_duration);
        });
      }
    });
  }

  void stopCountdown() {
    _timer.cancel();
    setState(() {
      _isCountdownActive = false;
      _duration = const Duration(minutes: 5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Page")),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(StickersGrid.routeName);
                  print('display stickers grid');
                },
                child: Image.asset(
                  _pathProvider.path,
                  height: 150,
                  width: 150,
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: DurationPicker(
              duration: _duration,
              onChange: (time) {
                setState(() => _duration = time);
              },
              snapToMins: 1.0,
            ),
          ),
          if (!_isCountdownActive)
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  startCountdown();
                },
                child: const Text("Start Session"),
              ),
            ),
          if (_isCountdownActive)
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () {
                    stopCountdown();
                    print("stop countdown");
                  },
                  child: const Text("Stop Session")),
            )
        ],
      ),
    );
  }
}
