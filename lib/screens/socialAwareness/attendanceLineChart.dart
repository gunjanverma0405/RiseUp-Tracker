import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class AttendanceLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                'Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 380,
              height: 250,// Adjust the width as needed
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(text: 'Session ID'),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Number of Attendees'),
                  labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                ),
                series: <LineSeries>[
                  LineSeries<SocialAwarenessSessionData, String>(
                    dataSource: getSocialAwarenessSessionData(),
                    xValueMapper: (SocialAwarenessSessionData data, _) => data.sessionName,
                    yValueMapper: (SocialAwarenessSessionData data, _) => data.attendance,
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


class SocialAwarenessSessionData {
  final String sessionName;
  final int attendance;

  SocialAwarenessSessionData(this.sessionName, this.attendance);
}


List<SocialAwarenessSessionData> getSocialAwarenessSessionData() {
  return [
    SocialAwarenessSessionData('1', 50),
    SocialAwarenessSessionData('2', 80),
    SocialAwarenessSessionData('3', 65),
    SocialAwarenessSessionData('4', 90),
    SocialAwarenessSessionData('5', 42),
    SocialAwarenessSessionData('6', 55),
    SocialAwarenessSessionData('7', 61),
  ];
}

