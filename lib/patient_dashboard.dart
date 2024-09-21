import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:patient/services/auth_service.dart';
import 'package:patient/temperature_history_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'history_screen.dart';

import 'package:provider/provider.dart'; // Use Provider for state management
// import 'auth_service.dart';

import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package


// Main Dashboard Widget
class PatientDashboard extends StatefulWidget {
  @override
  _PatientDashboardState createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    HistoryScreen(historyType: 'heartbeat'),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Dashboard'),
        backgroundColor: const Color.fromARGB(255, 170, 213, 241),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SignInDialog();
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.app_registration),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SignUpDialog();
                },
              );
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

// class PatientDashboard extends StatefulWidget {
//   @override
//   _PatientDashboardState createState() => _PatientDashboardState();
// }

// class _PatientDashboardState extends State<PatientDashboard> {
//   int _selectedIndex = 0;

//   // Patient details to be displayed
//   String _patientName = 'John Doe'; // Default name or empty if not available

//   static List<Widget> _widgetOptions = <Widget>[
//     DashboardScreen(),
//     HistoryScreen(historyType: 'heartbeat'),
//     SettingsScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Patient Dashboard'),
//         backgroundColor: const Color.fromARGB(255, 170, 213, 241),
//         elevation: 0,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.login),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return SignInDialog(onSignInSuccess: _handleSignInSuccess);
//                 },
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.app_registration),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return SignUpDialog();
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'History',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blueAccent,
//         onTap: _onItemTapped,
//       ),
//     );
//   }

//   void _handleSignInSuccess(String patientName) {
//     setState(() {
//       _patientName = patientName; // Update patient name
//     });
//   }
// }

// SignInDialog class
class SignInDialog extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sign In'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
         TextButton(
  child: Text('Sign In'),
  onPressed: () async {
    // await AuthService().signIn(
    //   email: usernameController.text,
    //   password: passwordController.text,
    //   context: context, // Pass the context from the parent widget
    // );
  },
),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Sign In'),
          onPressed: () {
            if (usernameController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a username')),
              );
            } else if (passwordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a password')),
              );
            } else {
              // Handle sign-in logic here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Successfully signed in!')),
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

// SignUpDialog class
class SignUpDialog extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sign Up'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          TextField(
            controller: ageController,
            decoration: InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: contactController,
            decoration: InputDecoration(labelText: 'Contact Number'),
            keyboardType: TextInputType.phone,
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(labelText: 'Address'),
          ),
          TextField(
            controller: bloodGroupController,
            decoration: InputDecoration(labelText: 'Blood Group'),
          ),
        ],
      ),
      
      
      actions: <Widget>[

        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
      child: Text('Sign Up'),
        onPressed: () async {
  // await AuthService1().signUp(
  //   context: context, // Add this line to pass the context argument
  //   email: emailController.text,
  //   password: passwordController.text,
  // );
},
        ),

        TextButton(
          child: Text('Sign Up'),
          onPressed: () {
            if (usernameController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a username')),
              );
            } else if (emailController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter an email')),
              );
            } else if (!emailController.text.contains('@')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a valid email')),
              );
            } else if (passwordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a password')),
              );
            } else if (ageController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter an age')),
              );
            } else if (contactController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a contact number')),
              );
            } else if (addressController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter an address')),
              );
            } else if (bloodGroupController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a blood group')),
              );
            } else {
              // Handle sign-up logic here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Successfully signed up!')),
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

// Dashboard Screen Widget
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PatientHeader(patientName: 'Mahee Jayawardhana'),
          VitalsSection(),
          PatientPosition(),
        ],
      ),
    );
  }
}

// 
class PatientHeader extends StatelessWidget {
  final String patientName;

  PatientHeader({required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Patient Information'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text('Name: $patientName'),
                        ),
                        // Add more details if needed
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                patientName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              // Add more patient details if needed
            ],
          ),
        ],
      ),
    );
  }
}

// Vitals Section Widget
class VitalsSection extends StatelessWidget {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StreamBuilder(
            stream: databaseReference.child('heart_rate/current').onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                String heartRate = 'N/A';
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  heartRate = snapshot.data!.snapshot.value.toString();
                }
                return VitalsCard(
                  title: 'HeartRate',
                  value: '$heartRate bpm',
                  icon: Icons.favorite,
                  historyType: 'heartbeat',
                );
              }
            },
          ),
          StreamBuilder(
            stream: databaseReference.child('temperatures/current').onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                String temperature = 'N/A';
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  temperature = snapshot.data!.snapshot.value.toString();
                }
                return VitalsCard(
                  title: 'Temperature',
                  value: '$temperature °C',
                  icon: Icons.thermostat,
                  historyType: 'temperature',
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VitalsCard(
            title: 'HeartRate',
            value: '72 bpm',
            icon: Icons.favorite,
            historyType: 'heartbeat',
          ),
          VitalsCard(
            title: 'Temperature',
            value: '36.6 °C',
            icon: Icons.thermostat,
            historyType: 'temperature',
          ),
        ],
      ),
    );
  }


// Vitals Card Widget
class VitalsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String historyType;

  VitalsCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.historyType,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (historyType == 'heartbeat') {
          Navigator.push(
            context,
            MaterialPageRoute(
             builder: (context) => HistoryScreen(historyType: 'heart_rate/logs'),
            ),
          );
        } else if (historyType == 'temperature') {
          Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TemperatureHistoryScreen(historyType: historyType),
  ),
);
        }
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Color.fromARGB(255, 196, 9, 50)),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 233, 145, 30)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PatientPosition extends StatelessWidget {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
   final String contactNumber = '+94778348789'; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Patient Position',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Icon(Icons.person_pin_circle, size: 100, color: Colors.blue),
          StreamBuilder(
            stream: databaseReference.child('position/current').onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                String position = 'Unknown';
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  position = snapshot.data!.snapshot.value.toString();
                }
                return Text(position);
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              _checkPatientPosition(context);
            },
            child: Text('Check Position'),
          ),
        ],
      ),
    );
  }


  void _checkPatientPosition(BuildContext context) {
  // Dummy condition for testing
  bool isFalling = true; // Replace with actual condition

  if (isFalling) {
    _sendAlert(context);
  }
}


 void _sendAlert(BuildContext context) async {
  // Construct message
  String message = 'Alert: The patient is detected as falling. Please check immediately.';

  // Send SMS
  await _sendSMS(message, [contactNumber]);

  // Make a call
  await _makePhoneCall('tel:$contactNumber');
}

Future<void> _sendSMS(String message, List<String> recipients) async {
  try {
    await sendSMS(
      message: message,
      recipients: recipients,
    );
  } catch (e) {
    print('Failed to send SMS: $e');
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

}


// Settings Screen Widget
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Page'),
    );
  }
}

