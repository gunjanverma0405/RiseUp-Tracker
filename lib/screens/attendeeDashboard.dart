import 'package:flutter/material.dart';
import 'package:riseuptracker/database/db_connects.dart';
import 'package:riseuptracker/screens/personalDetails.dart';
import 'package:riseuptracker/screens/qrcode/QRScanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import 'package:riseuptracker/screens/selectUserType.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  bool qrScanned = false;
  bool showUpcomingSessions = true;
  bool showPastSessions = false;
  bool showCurrentSessions = false;

  List<Session> attendedSessions = [];
  List<Session> currentSessions = [];
  List<Session> upcomingSessions = [];

  @override
  void initState() {
    super.initState();
    fetchSessions();
  }

  Future<String> getUserIdFromSession() async {
    final db = await mongo_dart.Db.create(dbURl);
    await db.open();

    final usersCollection = db.collection('Attendee');
    final user = await usersCollection.findOne(
      mongo_dart.where.eq('password', '123456'),
    );
    await db.close();

    String userId = user?['_id']?.toString() ?? '';
    print(userId);
    return userId;
  }

  Future<void> fetchSessions() async {
    final db = await mongo_dart.Db.create(dbURl);
    await db.open();

    final sessionsCollection = db.collection('Session');
    final sessions = await sessionsCollection.find().toList();

    final userId = await getUserIdFromSession(); // Wait for getUserIdFromSession to complete

    setState(() {
      final currentDate = DateTime.now();

      attendedSessions = sessions
          .where((session) => session['_id'] == userId)
          .map((session) => Session(
        id: session['_id'].toString(),
        title: session['Title'],
      ))
          .toList();

      currentSessions = sessions
          .where((session) {
        final sessionDate = session['Date'] is DateTime
            ? session['Date']
            : DateTime.parse(session['Date']);

        return sessionDate.year == currentDate.year &&
            sessionDate.month == currentDate.month &&
            sessionDate.day == currentDate.day;
      })
          .map((session) => Session(
        id: session['_id'].toString(),
        title: session['Title'],
        //sessionDate: session['Date'] is DateTime ? session['Date'].toString() : DateFormat('yyyy-MM-dd').format(session['Date']),
      ))
          .toList();

      upcomingSessions = sessions
          .where((session) {
        final sessionDate = session['Date'] is DateTime
            ? session['Date']
            : DateTime.parse(session['Date']);

        return sessionDate.year >= currentDate.year &&
            sessionDate.month >= currentDate.month &&
            sessionDate.day > currentDate.day;
      })
          .map((session) => Session(
        id: session['_id'].toString(),
        title: session['Title'],
        //sessionDate: session['Date'] is DateTime ? session['Date'].toString() : DateFormat('yyyy-MM-dd').format(session['Date']),
      ))
          .toList();



    });

    await db.close();
  }


  List<Session> getFilteredSessions() {
    if (showUpcomingSessions) {
      return upcomingSessions;
    } else if (showPastSessions) {
      return attendedSessions;
    } else {
      return currentSessions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserTypePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Sessions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FilterButton(
                      text: 'Upcoming',
                      isActive: showUpcomingSessions,
                      onPressed: () {
                        setState(() {
                          showUpcomingSessions = true;
                          showPastSessions = false;
                          showCurrentSessions = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: FilterButton(
                      text: 'Past',
                      isActive: showPastSessions,
                      onPressed: () {
                        setState(() {
                          showUpcomingSessions = false;
                          showPastSessions = true;
                          showCurrentSessions = false;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: FilterButton(
                      text: 'Ongoing',
                      isActive: showCurrentSessions,
                      onPressed: () {
                        setState(() {
                          showUpcomingSessions = false;
                          showPastSessions = false;
                          showCurrentSessions = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: getFilteredSessions().length,
                itemBuilder: (context, index) {
                  final session = getFilteredSessions()[index];
                  return buildSessionItem(session);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSessionItem(Session session) {
    final bool isOngoingSession = currentSessions.contains(session);

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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isOngoingSession && qrScanned) ...[
              IconButton(
                icon: Icon(Icons.feedback),
                onPressed: () {
                  // showFeedbackDialog(session.id);
                },
              ),
            ],
            if (isOngoingSession)
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
  }


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
}

class Session {
  final String id;
  final String title;

  Session({
    required this.id,
    required this.title,
  });
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onPressed;

  const FilterButton({
    required this.text,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          isActive ? Colors.blue : Colors.white,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          isActive ? Colors.white : Colors.blue,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.blue),
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
