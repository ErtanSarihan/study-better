import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:study_better/widgets/app_drawer.dart';

import '../provider/jwt_provider.dart';
import '../utils/leaderboard_data.dart';

class LeaderboardPage extends StatelessWidget {
  static const routeName = 'leaderboard';

  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    late final JwtProvider jwtProvider = Provider.of<JwtProvider>(
        context, listen: false);
    return FutureBuilder<List<Map<String, dynamic>>>(
        future:fetchLeaderboardData(jwtProvider),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show a loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final leaderboardData = snapshot.data!;
            return Scaffold(
              backgroundColor: const Color.fromRGBO(252, 255, 178, 0.8),
              appBar: AppBar(backgroundColor: const Color.fromRGBO(255, 211, 163, 1),
              ),
              drawer: const AppDrawer(),
              body: ListView.builder(
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  final entry = leaderboardData[index];
                  final username = entry['username'];
                  final totalDuration = entry['totalDuration'];
                  final duration = parseDuration(totalDuration);
                  final formattedDuration = formatDuration(duration);
                  final ranking = index + 1;

                  Color? backgroundColor;
                  Icon icon;

                  switch (ranking) {
                    case 1:
                      backgroundColor = Colors.green;
                      icon =
                      const Icon(Icons.emoji_events, color: Colors.amber);
                      break;
                    case 2:
                      backgroundColor = Colors.grey[300];
                      icon = const Icon(Icons.emoji_events, color: Colors.grey);
                      break;
                    case 3:
                      backgroundColor = Colors.brown[200];
                      icon =
                      const Icon(Icons.emoji_events, color: Colors.brown);
                      break;
                    default:
                      backgroundColor = Colors.transparent;
                      icon =
                      const Icon(Icons.emoji_events, color: Colors.black);
                  }

                  return Container(
                    color: backgroundColor,
                    child: ListTile(
                      leading: icon,
                      title: Text('$username'),
                      subtitle: Text(
                          'Focused for total of $formattedDuration minutes'),
                    ),
                  );
                },
              ),
            );
          }
        },
    );
  }


  Duration parseDuration(String durationString) {
    final durationRegex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
    final match = durationRegex.firstMatch(durationString);
    if (match != null) {
      final hours = int.tryParse(match.group(1) ?? '0') ?? 0;
      final minutes = int.tryParse(match.group(2) ?? '0') ?? 0;
      final seconds = int.tryParse(match.group(3) ?? '0') ?? 0;

      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    }

    return Duration.zero;
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    return minutes.toString();
  }

  Future<List<Map<String, dynamic>>> fetchLeaderboardData(jwtProvider) async {
    final url = Uri.parse(
        'http://192.168.1.20:8080/studybetter-api/v0/user/leaderboard');
    String token = jwtProvider.jwt;
    final headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer $token'
    };

    try {
      Response response = await get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to fetch leaderboard data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}