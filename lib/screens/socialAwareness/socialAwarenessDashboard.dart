import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;
import '../../database/db_connects.dart';
import '../createNewSession/create_new_sessions.dart';
import '../createNewSession/future_session_page.dart';
import '../createNewSession/ongoing_session_page.dart';
import '../createNewSession/past_session_page.dart';
import 'DemographicPieChart.dart';
import 'RatingBarGraph.dart';
import 'attendanceLineChart.dart';

class SocialAwarenessDashboard extends StatefulWidget {
  @override
  _SocialAwarenessDashboardState createState() =>
      _SocialAwarenessDashboardState();
}

enum SessionFilter {
  past,
  ongoing,
  upcoming,
}

class _SocialAwarenessDashboardState extends State<SocialAwarenessDashboard> {
  bool showGenderChart = false;
  bool showAgeChart = false;

  SessionFilter sessionFilter = SessionFilter.upcoming;

  List<SessionDetails> pastSessions = [];
  List<SessionDetails> currentSessions = [];
  List<SessionDetails> futureSessions = [];

  Future<void> fetchSessions() async {
    final db = await mongo_dart.Db.create(dbURl);
    await db.open();

    final sessionsCollection = db.collection('Session');
    final sessions = await sessionsCollection.find().toList();

    setState(() {
      final currentDate = DateTime.now();

      pastSessions = sessions
          .where((session) {
        final sessionDate = session['Date'];
        if (sessionDate is DateTime) {
          return sessionDate.isBefore(currentDate);
        } else if (sessionDate is String) {
          try {
            final parsedDate = DateTime.parse(sessionDate);
            return parsedDate.isBefore(currentDate);
          } catch (e) {
            return false;
          }
        }
        return false;
      })
          .map((session) => SessionDetails(
        sessionID: session['_id'].toString(),
        sessionTitle: session['Title'],
        sessionDate: session['Date'] is DateTime
            ? DateFormat('yyyy-MM-dd').format(session['Date'])
            : DateFormat('yyyy-MM-dd').format(DateTime.parse(session['Date'])),
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
          .map((session) => SessionDetails(
        sessionID: session['_id'].toString(),
        sessionTitle: session['Title'],
        sessionDate: session['Date'] is DateTime
            ? DateFormat('yyyy-MM-dd').format(session['Date'])
            : DateFormat('yyyy-MM-dd').format(DateTime.parse(session['Date'])),
      ))
          .toList();

      futureSessions = sessions
          .where((session) {
        final sessionDate = session['Date'];
        if (sessionDate is DateTime) {
          return sessionDate.isAfter(currentDate);
        } else if (sessionDate is String) {
          try {
            final parsedDate = DateTime.parse(sessionDate);
            return parsedDate.isAfter(currentDate);
          } catch (e) {
            return false;
          }
        }
        return false;
      })
          .map((session) => SessionDetails(
        sessionID: session['_id'].toString(),
        sessionTitle: session['Title'],
        sessionDate: session['Date'] is DateTime
            ? DateFormat('yyyy-MM-dd').format(session['Date'])
            : DateFormat('yyyy-MM-dd').format(DateTime.parse(session['Date'])),
      ))
          .toList();


    });

    await db.close();
  }

  List<SessionDetails> getSessionsByFilter(SessionFilter filter) {
    switch (filter) {
      case SessionFilter.past:
        return pastSessions;
      case SessionFilter.ongoing:
        return currentSessions;
      case SessionFilter.upcoming:
        return futureSessions;
      default:
        return [];
    }
  }

  // Navigate to the selected session page based on the session type
  void navigateToSessionPage(
    String sessionID,
    String sessionTitle,
    String sessionDate,
  ) {
    if (sessionFilter == SessionFilter.past) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PastSessionPage(
            sessionTitle: sessionTitle,
            sessionDate: sessionDate,
            sessionID: sessionID,
          ),
        ),
      );
    } else if (sessionFilter == SessionFilter.ongoing) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OngoingSessionPage(
            sessionTitle: sessionTitle,
            sessionDate: sessionDate,
            sessionID: sessionID,
          ),
        ),
      );
    } else if (sessionFilter == SessionFilter.upcoming) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FutureSessionPage(
            sessionTitle: sessionTitle,
            sessionDate: sessionDate,
            sessionID: sessionID,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Social Awareness'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: AttendanceLineChart(),
                ),
              ),
              SizedBox(height: 16.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RatingBarGraph(),
                ),
              ),
              SizedBox(height: 12.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ExpansionTile(
                  title: Text('Gender Distribution'),
                  collapsedBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  onExpansionChanged: (value) {
                    setState(() {
                      showGenderChart = value;
                    });
                  },
                  children: [
                    if (showGenderChart)
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: DemographicPieChart(
                          title: 'Gender Distribution',
                          data: getGenderData(),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ExpansionTile(
                  title: Text('Age Distribution'),
                  collapsedBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  onExpansionChanged: (value) {
                    setState(() {
                      showAgeChart = value;
                    });
                  },
                  children: [
                    if (showAgeChart)
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: DemographicPieChart(
                          title: 'Age Distribution',
                          data: getAgeData(),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CreateNewSessionPage(tileName: "Social Awareness"),
                      ),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text('Create New Session'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16.0),
                    Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FilterButton(
                              text: 'Past',
                              isActive: sessionFilter == SessionFilter.past,
                              onPressed: () {
                                setState(() {
                                  sessionFilter = SessionFilter.past;
                                });
                              },
                            ),
                            FilterButton(
                              text: 'Ongoing',
                              isActive: sessionFilter == SessionFilter.ongoing,
                              onPressed: () {
                                setState(() {
                                  sessionFilter = SessionFilter.ongoing;
                                });
                              },
                            ),
                            FilterButton(
                              text: 'Upcoming',
                              isActive: sessionFilter == SessionFilter.upcoming,
                              onPressed: () {
                                setState(() {
                                  sessionFilter = SessionFilter.upcoming;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    if (pastSessions.isEmpty &&
                        currentSessions.isEmpty &&
                        futureSessions.isEmpty)
                      Text('No sessions found')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: getSessionsByFilter(sessionFilter).length,
                        itemBuilder: (BuildContext context, int index) {
                          final session =
                              getSessionsByFilter(sessionFilter)[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  session.sessionTitle,
                                  style: TextStyle(fontSize: 18),
                                ),
                                subtitle: Text(
                                  "Date: ${session.sessionDate}",
                                  style: TextStyle(fontSize: 13),
                                ),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  navigateToSessionPage(
                                    session.sessionID,
                                    session.sessionTitle,
                                    session.sessionDate,
                                  );
                                },
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ],
                          );
                        },
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          fontSize: 15,
        ),
      ),
      style: ButtonStyle(
        backgroundColor:
            isActive ? MaterialStateProperty.all(Colors.blueAccent) : null,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: isActive
                ? BorderSide.none
                : BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}

class SessionDetails {
  final String sessionID;
  final String sessionTitle;
  final String sessionDate;

  SessionDetails({
    required this.sessionID,
    required this.sessionTitle,
    required this.sessionDate,
  });
}
