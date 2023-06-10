import 'package:flutter/material.dart';
import 'package:riseuptracker/screens/qrcode/QRScanner.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  bool qrScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Session Page'),
      ),
      body: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/User.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return Card(
                  child: ListTile(
                    title: Text(session.title),
                    subtitle: Text(session.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (qrScanned) ...[
                          IconButton(
                            icon: Icon(Icons.feedback),
                            onPressed: () {
                              // Handle feedback button press
                              // based on the session ID
                            },
                          ),
                        ],
                        IconButton(
                          icon: Icon(Icons.qr_code),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QRScanPage(
                                  sessionID: session.id,
                                  onQRScanned: () {
                                    setState(() {
                                      qrScanned = true;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Session {
  final String id;
  final String title;
  final String description;

  Session({
    required this.id,
    required this.title,
    required this.description,
  });
}

final List<Session> sessions = [
  Session(
    id: '1',
    title: 'Session 1',
    description: 'Description of session 1',
  ),
  Session(
    id: '2',
    title: 'Session 2',
    description: 'Description of session 2',
  ),
  Session(
    id: '3',
    title: 'Session 3',
    description: 'Description of session 3',
  ),
];
