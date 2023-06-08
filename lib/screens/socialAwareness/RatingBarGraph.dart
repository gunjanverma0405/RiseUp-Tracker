import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RatingBarGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: SfCartesianChart(
        title: ChartTitle(
          text: 'Overall Rating',
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontStyle: FontStyle.normal,
          ),
          alignment: ChartAlignment.near,
        ),
        primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Ratings')),
        primaryYAxis: NumericAxis(title: AxisTitle(text: 'Number of Attendees')),
        series: <BarSeries>[
          BarSeries<SocialAwarenessSessionData, String>(
            dataSource: getSocialAwarenessSessionData(),
            xValueMapper: (SocialAwarenessSessionData data, _) => data.rating,
            yValueMapper: (SocialAwarenessSessionData data, _) => data.avgCount,
            enableTooltip: true,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            pointColorMapper: (SocialAwarenessSessionData data, _) {
              if (data.rating == '5') {
                return Colors.green; // Color for rating 5
              } else if (data.rating == '4') {
                return Colors.lightGreen; // Color for rating 4
              } else if (data.rating == '3') {
                return Colors.yellow; // Color for rating 3
              } else if (data.rating == '2') {
                return Colors.orange; // Color for rating 2
              } else if (data.rating == '1') {
                return Colors.red; // Color for rating 1
              } else {
                return Colors.blue; // Default color for bars
              }
            },
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }
}


class SocialAwarenessSessionData {
  final String rating;
  final int avgCount;

  SocialAwarenessSessionData(this.avgCount, this.rating);
}

List<SocialAwarenessSessionData> getSocialAwarenessSessionData() {
  return [
    SocialAwarenessSessionData(40, '5'),
    SocialAwarenessSessionData(30, '4'),
    SocialAwarenessSessionData(20, '3'),
    SocialAwarenessSessionData(5, '2'),
    SocialAwarenessSessionData(5, '1'),

  ];
}
