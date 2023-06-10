import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo_dart;

import '../../database/db_connects.dart';
import '../createNewSession/create_new_sessions.dart';
import 'DemographicPieChart.dart';
import 'RatingBarGraph.dart';
import 'attendanceLineChart.dart';


class socialAwarenessDashboard extends StatefulWidget {
  @override
  _socialAwarenessDashboardState createState() =>
      _socialAwarenessDashboardState();
}

enum SessionFilter {
  past,
  ongoing,
  upcoming,
}

class _socialAwarenessDashboardState extends State<socialAwarenessDashboard> {
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
          .where((session) => session['date'].toDate().isBefore(currentDate))
          .map((session) => SessionDetails(
        sessionId: session['_id'].toString(),
        sessionTitle: session['title'],
        sessionDate:
        DateFormat('yyyy-MM-dd').format(session['date'].toDate()),
      ))
          .toList();
      currentSessions = sessions
          .where((session) =>
          session['date'].toDate().isAtSameMomentAs(currentDate))
          .map((session) => SessionDetails(
        sessionId: session['_id'].toString(),
        sessionTitle: session['title'],
        sessionDate:
        DateFormat('yyyy-MM-dd').format(session['date'].toDate()),
      ))
          .toList();

      futureSessions = sessions
          .where((session) =>
          session['date'].toDate().isAfter(currentDate))
          .map((session) => SessionDetails(
        sessionId: session['_id'].toString(),
        sessionTitle: session['title'],
        sessionDate:
        DateFormat('yyyy-MM-dd').format(session['date'].toDate()),
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
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.white,
            iconSize: 40,
            onPressed: null,
          ),
        ],
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    //itemCount: sessionDetails.length,
                    itemBuilder: (context, index) {
                      List<SessionDetails> sessions = getSessionsByFilter(sessionFilter);
                      if (sessions.isEmpty) {
                        // if empty array
                        return Center(child: Text('No sessions available.'));
                      }
                      SessionDetails session = sessions[index];
                      return GestureDetector(
                        onTap: () {
                          itemBuilder:
                              (context, index) {
                                SessionDetails session = pastSessions[index];
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => SessionScreen(session)),
                                // );
                              };
                          child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey)),
                          ),
                          child: ListTile(
                          title: Text(
                          session.sessionTitle, // Updated line
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          ),
                          ),
                          subtitle: Text(
                          'Date: ${session.sessionDate}',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          ),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          ),

                          );
                        },
                      );
                    },
                ),
              ),
              ),
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

class SessionDetails {
  final String sessionId;
  final String sessionTitle;
  final String sessionDate;

  SessionDetails({
    required this.sessionId,
    required this.sessionTitle,
    required this.sessionDate,
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
          isActive ? Colors.blueAccent : Colors.grey,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
