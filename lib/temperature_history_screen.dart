import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart'; // Import for DateFormat
import 'model/chart_data.dart';

class TemperatureHistoryScreen extends StatefulWidget {
  final String historyType;
  const TemperatureHistoryScreen({Key? key, required this.historyType})
      : super(key: key);

  @override
  _TemperatureHistoryScreenState createState() => _TemperatureHistoryScreenState();
}

class _TemperatureHistoryScreenState extends State<TemperatureHistoryScreen> {
  List<ChartData> data = [];

  @override
  void initState() {
    super.initState();
    fetchTemperatureData();
  }

  void fetchTemperatureData() async {
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('temperature/logs').onValue.listen((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final dataList = <ChartData>[];
        final values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          final timestamp = int.parse(key);
          final temperature = double.parse(value['current'].toString());
          final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
          dataList.add(ChartData(dateTime, temperature));
        });
        dataList.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // Sort by dateTime
        setState(() {
          data = dataList;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature History'),
        backgroundColor: Color.fromARGB(255, 170, 213, 241),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Temperature',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 20),
          const CircleAvatar(
            backgroundImage: NetworkImage("lib/style/2944675.png"),
            radius: 36.0,
          ),
          const SizedBox(height: 10.0),
          Text(
            "${data.isNotEmpty ? data.last.value.toString() : 'Loading...'}°C",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Text(
            "Current Temperature",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                intervalType: DateTimeIntervalType.days,
                dateFormat: DateFormat('dd/MM'),
                title: AxisTitle(text: 'Date'),
                majorGridLines: MajorGridLines(width: 0.5, color: Colors.grey),
                axisLine: AxisLine(width: 0.5),
                labelStyle: TextStyle(color: Colors.black),
              ),
              primaryYAxis: NumericAxis(
                minimum: data.isNotEmpty ? (data.map((e) => e.value).reduce((a, b) => a < b ? a : b)) - 0.5 : 36,
                maximum: data.isNotEmpty ? (data.map((e) => e.value).reduce((a, b) => a > b ? a : b)) + 0.5 : 38,
                interval: 0.5,
                title: AxisTitle(text: 'Temperature (°C)'),
                majorGridLines: MajorGridLines(width: 0.5, color: Colors.grey),
                axisLine: AxisLine(width: 0.5),
                labelStyle: TextStyle(color: Colors.black),
              ),
              series: <CartesianSeries>[
                SplineSeries<ChartData, DateTime>(
                  dataSource: data,
                  xValueMapper: (ChartData data, _) => data.dateTime,
                  yValueMapper: (ChartData data, _) => data.value,
                  color: Colors.blue,
                  splineType: SplineType.natural,
                ),
              ],
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          ),
        ],
      ),
    );
  }
}

// Model class
class ChartData {
  final DateTime dateTime;
  final double value;

  ChartData(this.dateTime, this.value);
}
