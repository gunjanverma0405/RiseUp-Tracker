
import 'package:flutter/material.dart';
import 'package:riseuptracker/database/db_connects.dart';
import 'package:riseuptracker/screens/personalDetails.dart';
import 'package:riseuptracker/screens/qrcode/QRScanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  bool qrScanned = false;
  List<Session> sessions = [];

  @override
  void initState() {
    super.initState();
    fetchSessionsFromDatabase();
  }

  void fetchSessionsFromDatabase() async {
    final db = await mongo_dart.Db.create(dbURL);
    try {
      await db.open();
      final collection = db.collection('sessions');
      final sessionsData = await collection.find().toList();
      setState(() {
        sessions = sessionsData
            .map((data) => Session(
          id: data['id'],
          title: data['title'],
          description: data['description'],
        ))
            .toList();
      });
    } catch (e) {
      print('Failed to fetch sessions: $e');
    } finally {
      await db.close();
    }
  }

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
            ],
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
                              showFeedbackDialog(session.id);
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
                                    storeAttendance(session.id);
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

void showFeedbackDialog(BuildContext context, String sessionID) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String feedback = '';
      return AlertDialog(
        title: Text('Provide Feedback'),
        content: TextField(
          decoration: InputDecoration(
            labelText: 'Feedback',
            border: OutlineInputBorder(),
          ),
          maxLines: null,
          keyboardType: TextInputType.multiline,
          onChanged: (value) {
            feedback = value;
          },
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Submit'),
            onPressed: () {
              storeFeedback(sessionID, feedback);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// The rest of the code remains the same

// Store feedback in MongoDB
/*void storeFeedback(String sessionID, String feedback) async {
  final db =  await mongo_dart.Db.create(dbURl);
  try {

    final collection = 'feedback';
    await db.open();

    final feedbackDocument = {
      'sessionID': sessionID,
      'feedback': feedback,
    };

    await db.collection(collection).insert(feedbackDocument);

    setState(() {
      sessions.firstWhere((session) => session.id == sessionID).feedback = feedback;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Feedback submitted')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to submit feedback')),
    );
  } finally {
    await db.close();
  }
}*/

void storeAttendance(String sessionID) async {
  final db = await mongo_dart.Db.create(dbURl);
  try {

    await db.open();

    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';

    final attendanceDocument = {
      'user_id': userId,
      'session_id': sessionID,
      'timestamp': DateTime.now(),
    };

    await db.collection("Attendance").insert(attendanceDocument);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attendance recorded')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to record attendance')),
    );
  } finally {
    await db.close();
  }
}

class SessionDetails {
  final String id;
  final String title;
  final String description;

  SessionDetails({
    required this.id,
    required this.title,
    required this.description,
  });
}
//
// final List<Session> sessions = [
//   Session(
//     id: '1',
//     title: 'Session 1',
//     description: 'Description of session 1',
//   ),
//   Session(
//     id: '2',
//     title: 'Session 2',
//     description: 'Description of session 2',
//   ),
//   Session(
//     id: '3',
//     title: 'Session 3',
//     description: 'Description of session 3',
//   ),
// ];