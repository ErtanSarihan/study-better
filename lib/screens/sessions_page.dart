// future builder -> fetchSessions
// Duration.parse()
// create session card objects ->success green failed red
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_better/models/session.dart';
import 'package:http/http.dart';
import 'package:study_better/widgets/app_drawer.dart';

import '../provider/jwt_provider.dart';
import '../widgets/session_card.dart';
import '../widgets/sessions_chart.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({Key? key}) : super(key: key);
  static const routeName = 'sessions';

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  List<Session> _sessions = [];
  late final JwtProvider _jwtProvider = Provider.of<JwtProvider>(
      context, listen: false);


  @override
  void initState() {
    super.initState();
    fetchSessions();
  }

  Future<void> fetchSessions() async {
    final url = Uri.parse(
        'http://192.168.1.20:8080/studybetter-api/v0/user/sessions');
    String token = _jwtProvider.jwt;
    final headers = {
      "Content-type": "application/json",
      'Authorization': 'Bearer $token'
    };
    try {
      Response response = await get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonSessions = jsonDecode(response.body) as List<dynamic>;

        final fetchedSessions = jsonSessions.map((jsonSession) {
          final durationString = jsonSession['duration'];
          final duration = parseDuration(durationString);

          return Session(
            id: jsonSession['id'],
            startedAt: DateTime.parse(jsonSession['startedAt']),
            duration: duration,
            successStatus: jsonSession['successStatus'],
          );
        }).toList();

        setState(() {
          _sessions = fetchedSessions;
        });
      } else {
        throw Exception('Failed to fetch sessions');
      }
    } catch (error) {
      print('Error fetching sessions: $error');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 211, 163, 1),
      ),
      drawer: const AppDrawer(),
      body: Container(
        color: const Color.fromRGBO(252, 255, 178, 0.8),
        child: Column(
          children: [
            SizedBox(
              height: 200, // Set the height as needed
              child: SessionsBarChart(sessions: _sessions),
            ),
            Expanded(
              child: _sessions.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: _sessions.length,
                itemBuilder: (context, index) {
                  return SessionCard(session: _sessions[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Duration parseDuration(String durationString) {
  final hoursPattern = RegExp(r'(\d+)H');
  final minutesPattern = RegExp(r'(\d+)M');
  final secondsPattern = RegExp(r'(\d+)S');

  final hoursMatch = hoursPattern.firstMatch(durationString);
  final minutesMatch = minutesPattern.firstMatch(durationString);
  final secondsMatch = secondsPattern.firstMatch(durationString);

  int hours = hoursMatch != null ? int.parse(hoursMatch.group(1)!) : 0;
  int minutes = minutesMatch != null ? int.parse(minutesMatch.group(1)!) : 0;
  int seconds = secondsMatch != null ? int.parse(secondsMatch.group(1)!) : 0;

  return Duration(hours: hours, minutes: minutes, seconds: seconds);
}

