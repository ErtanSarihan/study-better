import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/session.dart';

class SessionCard extends StatelessWidget {
  final Session session;

  const SessionCard({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final formattedDateTime = DateFormat('MMM dd, yyyy hh:mm a').format(session.startedAt);
    return Card(
      color: session.successStatus ? Colors.green[400] : Colors.red[300],
      child: ListTile(
        title: Text('${session.duration.inMinutes} minutes'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Started At: $formattedDateTime'),
            Text('Success Status: ${session.successStatus}'),
          ],
        ),
      ),
    );
  }
}
