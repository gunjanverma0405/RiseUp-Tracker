import 'package:flutter/material.dart';
import 'package:riseuptracker/screens/MarkAttendance.dart';
import '../qrcode/GenerateQRcode.dart';

class OngoingSessionPage extends StatelessWidget {
  final String sessionTitle;
  final String sessionDate;
  final String sessionID;

  OngoingSessionPage(
      {required this.sessionTitle,
      required this.sessionDate,
      required this.sessionID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Session Attendance'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
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
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GeneratePage(
                        initialData: sessionID,
                      ),
                    ),
                  );
                },
                child: Text(
                  'QR Code for Attendance',
                  style: TextStyle(
                    fontSize: 20, // Adjust the font size as desired
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendancePage(
                        sessionTitle: sessionTitle,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Mark Attendance',
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
