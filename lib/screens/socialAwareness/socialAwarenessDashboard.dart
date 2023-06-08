import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'DemographicPieChart.dart';
import 'RatingBarGraph.dart';
import 'attendanceLineChart.dart';

class socialAwarenessDashboard extends StatefulWidget {
  @override
  _socialAwarenessDashboardState createState() => _socialAwarenessDashboardState();
}

class _socialAwarenessDashboardState extends State<socialAwarenessDashboard> {
  bool showGenderChart = false;
  bool showAgeChart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Social Awareness'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}

