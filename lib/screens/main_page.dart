import 'dart:async';
import 'dart:io';

import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:study_better/provider/jwt_provider.dart';
import 'package:study_better/provider/path_provider.dart';
import 'package:study_better/screens/market_page.dart';
import 'package:study_better/screens/stickers_grid.dart';
import 'package:study_better/provider/sticker_provider.dart';
import 'package:study_better/widgets/app_drawer.dart';
import 'package:study_better/widgets/time_picker.dart';

import '../models/sticker.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const routeName = 'main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Duration _duration = const Duration(hours: 0, minutes: 5);
  Duration _durationHolder = const Duration(hours: 0, minutes: 5);
  late Timer _timer;
  bool _isCountdownActive = false;
  late final PathProvider _pathProvider = Provider.of<PathProvider>(context);
  late final JwtProvider _jwtProvider = Provider.of<JwtProvider>(context, listen: false);
  static const coinRewardUrlPrefix = 'http://192.168.1.20:8080/studybetter-api/v0/sessions/reward';
  static const addSessionUrl = 'http://192.168.1.20:8080/studybetter-api/v0/sessions';

  void _rewardUser(rewardAmount) async {
    String token = _jwtProvider.jwt;
    final url = Uri.parse('$coinRewardUrlPrefix/$rewardAmount');
    final headers = {"Content-type": "application/json", 'Authorization': 'Bearer $token'};
    Response response = await post(url, headers: headers);
    print(response.statusCode);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reward Given'),
          content: Text('You have been rewarded with the sticker you choose and ${_durationHolder.inMinutes} coins.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveSuccessfulSession(startedAt) async {
    String token = _jwtProvider.jwt;
    final url = Uri.parse(addSessionUrl);
    final headers = {"Content-type": "application/json", 'Authorization': 'Bearer $token'};
    final body = '{"startedAt": "$startedAt", "duration": "$_durationHolder", "successStatus": "true"}';
    Response response = await post(url, headers: headers, body: body);
    print(response.statusCode);
  }

  void startCountdown(BuildContext context) {
    final now = DateTime.now();
    const oneSec = Duration(seconds: 1);
    _durationHolder = _duration;
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_duration <= oneSec) {
        setState(() {
          timer.cancel();
          _isCountdownActive = false;
          final StickerProvider stickerProvider =
              context.read<StickerProvider>();
          Sticker sticker = stickerProvider.stickers
              .firstWhere((sticker) => sticker.path == _pathProvider.path);
          stickerProvider.incrementOwnedAmount(sticker.id);
          print(stickerProvider.stickers
              .map((e) => e.toString())
              .toList()
              .toString());
          print("duration was: $_durationHolder");
          int rewardAmount = _durationHolder.inMinutes;
          _rewardUser(rewardAmount);
          _showDialog(context);
          _saveSuccessfulSession(now);
          // session kaydetme
        });
      } else {
        if (!mounted) {
          return;
        }
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromRGBO(255, 211, 163, 1),),
      drawer: const AppDrawer(),
      body: Container(
        color: Colors.green[100],
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(StickersGrid.routeName);
                    print('display stickers grid');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(252, 255, 178, 0.6),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset(
                      _pathProvider.path,
                      height: 150,
                      width: 150,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: DurationPicker(
                duration: _duration,
                onChange: (time) {
                  setState(() => _duration = time);
                },
                snapToMins: 1,
              ),
            ),
            if (!_isCountdownActive)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 70, top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      startCountdown(context);
                    },
                    child: const Text("Start Session"),
                  ),
                ),
              ),
            if (_isCountdownActive)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 70, top: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        stopCountdown();
                        print("stop countdown");
                      },
                      child: const Text("Stop Session")),
                ),
              )
          ],
        ),
      ),
    );
  }
}
