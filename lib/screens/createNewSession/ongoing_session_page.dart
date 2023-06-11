import 'package:flutter/material.dart';

class OngoingSessionPage extends StatelessWidget {
  final String sessionTitle;
  final String sessionDate;
  final String sessionID;

  OngoingSessionPage({required this.sessionTitle, required this.sessionDate, required this.sessionID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Ongoing Session'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: double.infinity,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Title: $sessionTitle',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Date: $sessionDate',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                  // You can navigate to the attendance page or perform any other action
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  onPrimary: Colors.white,
                ),
                child: Text(
                  'Take Attendance',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size as desired
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
