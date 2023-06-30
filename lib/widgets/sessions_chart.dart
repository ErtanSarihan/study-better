import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/session.dart';
class SessionsBarChart extends StatelessWidget {
  final List<Session> sessions;

  const SessionsBarChart({super.key, required this.sessions});

  @override
  Widget build(BuildContext context) {
    final List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    // Create a map to store the total successful session duration by day
    final Map<int, int> totalSuccessfulDurationByDay = {};

    // Create a map to store the total unsuccessful session duration by day
    final Map<int, int> totalUnsuccessfulDurationByDay = {};

    // Iterate over the sessions and accumulate the total duration by day for successful and unsuccessful sessions
    for (final session in sessions) {
      final dayOfWeek = session.startedAt.weekday;
      if (session.successStatus) {
        totalSuccessfulDurationByDay[dayOfWeek] = (totalSuccessfulDurationByDay[dayOfWeek] ?? 0) + session.duration.inMinutes;
      } else {
        totalUnsuccessfulDurationByDay[dayOfWeek] = (totalUnsuccessfulDurationByDay[dayOfWeek] ?? 0) + session.duration.inMinutes;
      }
    }

    // Calculate the maximum y-value
    final maxSuccessfulDuration = totalSuccessfulDurationByDay.isEmpty
        ? 0
        : totalSuccessfulDurationByDay.values.reduce((maxValue, value) => maxValue > value ? maxValue : value);
    final maxUnsuccessfulDuration = totalUnsuccessfulDurationByDay.isEmpty
        ? 0
        : totalUnsuccessfulDurationByDay.values.reduce((maxValue, value) => maxValue > value ? maxValue : value);
    final maxY = (maxSuccessfulDuration ~/ 10 + 1) * 10;

    // Custom function to determine the y-axis labels
    String getAxisTitle(double value) {
      if (value % 30 == 0) {
        return value.toString();
      }
      return '';
    }

    return BarChart(
      BarChartData(
        barGroups: List.generate(daysOfWeek.length, (index) {
          final dayIndex = index + 1;
          final successfulDuration = totalSuccessfulDurationByDay[dayIndex] ?? 0;
          final unsuccessfulDuration = totalUnsuccessfulDurationByDay[dayIndex] ?? 0;

          return BarChartGroupData(
            x: dayIndex.toInt(),
            barRods: [
              BarChartRodData(
                y: successfulDuration.toDouble(),
                colors: [Colors.green],
                width: 12,
              ),
              BarChartRodData(
                y: unsuccessfulDuration.toDouble(),
                colors: [Colors.red],
                width: 12,
              ),
            ],
          );
        }),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY.toDouble(),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
            margin: 16,
            getTitles: (double value) {
              final dayIndex = value.toInt();
              if (dayIndex >= 1 && dayIndex <= daysOfWeek.length) {
                return daysOfWeek[dayIndex - 1];
              }
              return '';
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
            margin: 16,
            reservedSize: 30,
            interval: 30,
            getTitles: getAxisTitle,
          ),
        ),
      ),
    );
  }
}
