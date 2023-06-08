import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DemographicPieChart extends StatelessWidget {
  final String title;
  final List<ChartData> data;

  DemographicPieChart({required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Adjust the height as needed
      child: SfCircularChart(
        title: ChartTitle(
          text: title,
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.value,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside,
              textStyle: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}

List<ChartData> getGenderData() {
  return [
    ChartData('Men', 40),
    ChartData('Women', 60),
  ];
}

List<ChartData> getAgeData() {
  return [
    ChartData('Below 20', 20),
    ChartData('20-35', 40),
    ChartData('35-50', 30),
    ChartData('Above 50', 10),
  ];
}
