import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../createNewSession/create_new_sessions.dart';
import 'DemographicPieChart.dart';
import 'RatingBarGraph.dart';
import 'attendanceLineChart.dart';

class socialAwarenessDashboard extends StatefulWidget {
  @override
  _socialAwarenessDashboardState createState() =>
      _socialAwarenessDashboardState();
}

class _socialAwarenessDashboardState extends State<socialAwarenessDashboard> {
  bool showGenderChart = false;
  bool showAgeChart = false;

  List<SessionDetails> sessionDetails = [
    SessionDetails(
      sessionId: '1',
      sessionTitle: 'Raising Awareness on Mental Health',
      sessionDate: '06-10-2022',
    ),
    SessionDetails(
      sessionId: '4',
      sessionTitle: 'Fighting Online Harassment',
      sessionDate: '06-10-2022',
    ),
    SessionDetails(
      sessionId: '7',
      sessionTitle: 'Protecting Our Environment',
      sessionDate: '06-10-2022',
    ),
  ];

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
                      MaterialPageRoute(builder: (context) => CreateNewSessionPage(tileName: "Social Awareness",)),
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: sessionDetails.length,
                  itemBuilder: (context, index) {
                    SessionDetails session = sessionDetails[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the corresponding screen on session click
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => SessionScreen(session)),
                        // );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey)),
                        ),
                        child: ListTile(
                          title: Text(
                            'Session ${session.sessionId}: ${session.sessionTitle}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          subtitle: Text(
                            'Date: ${session.sessionDate}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
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
