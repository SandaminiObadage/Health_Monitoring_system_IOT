import 'package:flutter/material.dart';
import 'patient_dashboard.dart';
import 'history_screen.dart';
import 'chart_data.dart';// Assuming you have a separate file for ChartData
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';


// import 'patient_data.dart';  // Import your PatientData model


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(PatientApp());
}

class PatientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PatientDashboard(),
    );
  }
} 