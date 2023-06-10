import 'package:flutter/material.dart';
import 'package:riseuptracker/screens/socialAwareness/socialAwarenessDashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Dashboard'),
        automaticallyImplyLeading: false,
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
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 320,
                    padding: EdgeInsets.all(10.0),
                    child: AttendanceLineChart(
                      data: getAttendanceData(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 250,
                    padding: EdgeInsets.all(10.0),
                    child: RatingBarGraph(
                      data: getRatingData(),
                    ),
                  ),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: [
                  buildTile(context, 'Education', Icons.school, 'Screen 1'),
                  buildTile(context, 'Social Awareness',Icons.people, 'socialAwarenessDashboard'),
                  buildTile(context, 'Health', Icons.favorite, 'Screen 3'),
                  buildTile(context, 'Finance', Icons.attach_money, 'Screen 2'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTile(BuildContext context, String title, IconData icon, String screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  socialAwarenessDashboard()),
        );
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Stack(
          children: [

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 70,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}


class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}

class AttendanceLineChart extends StatelessWidget {
  final List<ChartData> data;

  AttendanceLineChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
              child: Text(
                'Overall Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 380,
              height: 255,// Adjust the width as needed
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(text: 'Session ID'),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Number of Attendees'),
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                ),
                series: <LineSeries>[
                  LineSeries<ChartData, String>(
                    dataSource: data,
                    xValueMapper: (ChartData data, _) => data.category,
                    yValueMapper: (ChartData data, _) => data.value,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                    ),
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  animationDuration: 500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingBarGraph extends StatelessWidget {
  final List<ChartData> data;

  RatingBarGraph({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          title: AxisTitle(
            text: 'Type of Session',
            textStyle: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        primaryYAxis: CategoryAxis(
          title: AxisTitle(
            text: 'Average Rating',
            textStyle: TextStyle(
              fontSize: 16,

            ),
          ),
        ),
        title: ChartTitle(
          text: 'Overall Ratings',
          textStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          alignment: ChartAlignment.near,
        ),

        series: <BarSeries<ChartData, String>>[
          BarSeries<ChartData, String>(
            dataLabelSettings: DataLabelSettings(isVisible: true),
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.value,

            pointColorMapper: (ChartData data, _) {
              if (data.category == 'Social Awareness') {
                return Colors.blue;
              } else if (data.category == 'Health') {
                return Colors.green;
              } else if (data.category == 'Education') {
                return Colors.orange;
              } else if (data.category == 'Finance') {
                return Colors.red;
              }
              return Colors.grey;
            },
          ),
        ],
      ),
    );
  }
}

List<ChartData> getAttendanceData() {
  return [
    ChartData('1', 50),
    ChartData('2', 70),
    ChartData('3', 40),
    ChartData('4', 60),
    ChartData('5', 80),
    ChartData('6', 82),
    ChartData('7', 44),
    ChartData('8', 59),
    ChartData('9', 78),
    ChartData('10', 54),
    ChartData('11', 66)
  ];
}

List<ChartData> getRatingData() {
  return [
    ChartData('Social Awareness', 4.8),
    ChartData('Health', 3.5),
    ChartData('Education', 3.1),
    ChartData('Finance', 4.6),
  ];
}