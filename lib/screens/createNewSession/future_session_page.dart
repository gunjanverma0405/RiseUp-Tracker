import 'package:flutter/material.dart';

class FutureSessionPage extends StatelessWidget {
  final String sessionTitle;
  final String sessionDate;
  final String sessionID;

  FutureSessionPage({required this.sessionTitle, required this.sessionDate, required this.sessionID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Session'),
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
