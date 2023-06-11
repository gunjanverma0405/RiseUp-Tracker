import 'package:flutter/material.dart';

class OngoingSessionPage extends StatelessWidget {
  final String sessionTitle;
  final String sessionDate;

  OngoingSessionPage({required this.sessionTitle, required this.sessionDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongoing Session'),
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
