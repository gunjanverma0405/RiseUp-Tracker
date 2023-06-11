import 'package:flutter/material.dart';
import 'package:riseuptracker/screens/personalDetails.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(""),
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonalDetails(),
              ),
            );
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Handle the logout button press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              /*Container(
                width: 300,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Logo2.png'),
                  ),
                ),
              ),*/
              /*IconButton(
                icon: Icon(Icons.edit), // Edit icon
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonalDetails()));
                },
              ),*/
            ],
          ),
          SizedBox(height: 25),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Your Sessions',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
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
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    title: Text(
                      session.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
