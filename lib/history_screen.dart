import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart'; // Import for DateFormat

class HistoryScreen extends StatefulWidget {
  final String historyType;

  const HistoryScreen({Key? key, required this.historyType}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late DatabaseReference _databaseReference;
  List<ChartData> _data = [];

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.reference().child(widget.historyType);

    // Set up listener for data changes
    _databaseReference.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        List<ChartData> newData = [];
        data.forEach((key, value) {
          final timestamp = int.parse(key);
          final beatsPerMinute = double.parse(value['current'].toString());
          final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
          newData.add(ChartData(dateTime, beatsPerMinute));
        });

        newData.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // Sort by dateTime
        setState(() {
          _data = newData;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      appBar: AppBar(
        backgroundColor: AppStyle.bgColor,
        elevation: 0,
        title: Text('${widget.historyType} BPM Rate'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Heart Rate',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 20),
          const CircleAvatar(
            backgroundImage: NetworkImage("lib/style/Main-heart-rate.jpg"),
            radius: 36.0,
          ),
          const SizedBox(height: 10.0),
          Text(
            "${_data.isNotEmpty ? _data.last.value : 'N/A'} BPM",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Text(
            "BPM",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(
            child: SfCartesianChart(
              margin: const EdgeInsets.all(20),
              borderWidth: 0,
              borderColor: Colors.transparent,
              plotAreaBorderWidth: 0,
              primaryXAxis: DateTimeAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                intervalType: DateTimeIntervalType.hours,
                dateFormat: DateFormat('HH:mm'),
                title: AxisTitle(text: 'Time'),
                majorGridLines: MajorGridLines(width: 0.5, color: Colors.grey),
                axisLine: AxisLine(width: 0.5),
                labelStyle: TextStyle(color: Colors.black),
              ),
              primaryYAxis: NumericAxis(
                minimum: _data.isNotEmpty ? (_data.map((e) => e.value).reduce((a, b) => a < b ? a : b)) - 10 : 0,
                maximum: _data.isNotEmpty ? (_data.map((e) => e.value).reduce((a, b) => a > b ? a : b)) + 10 : 100,
                interval: 10,
                title: AxisTitle(text: 'Heartbeat (BPM)'),
                majorGridLines: MajorGridLines(width: 0.5, color: Colors.grey),
                axisLine: AxisLine(width: 0.5),
                labelStyle: TextStyle(color: Colors.black),
              ),
              series: <CartesianSeries>[
                SplineSeries<ChartData, DateTime>(
                  dataSource: _data,
                  xValueMapper: (ChartData data, _) => data.dateTime,
                  yValueMapper: (ChartData data, _) => data.value,
                  color: Colors.red,
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

class AppStyle {
  static const Color bgColor = Colors.white;
  static const Color splineColor = Colors.red; // Replace with your desired color
}

class ChartData {
  final DateTime dateTime;
  final double value;

  ChartData(this.dateTime, this.value);
}
