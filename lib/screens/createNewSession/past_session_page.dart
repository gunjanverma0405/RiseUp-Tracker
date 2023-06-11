import 'package:flutter/material.dart';

class PastSessionPage extends StatelessWidget {
  final String sessionTitle;
  final String sessionDate;
  final String sessionID;

  PastSessionPage({required this.sessionTitle, required this.sessionDate, required this.sessionID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Session'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              sessionTitle,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Date: $sessionDate',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
