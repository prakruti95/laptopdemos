import 'package:flutter/material.dart';
import 'package:flutter_accelerometer_plugin/flutter_accelerometer_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccelerometerScreen(),
    );
  }
}

class AccelerometerScreen extends StatefulWidget {
  @override
  _AccelerometerScreenState createState() => _AccelerometerScreenState();
}

class _AccelerometerScreenState extends State<AccelerometerScreen> {
  List<double> _accelerometerData = [0.0, 0.0, 0.0];

  @override
  void initState() {
    super.initState();
    _getAccelerometerData();
  }

  // Get accelerometer data
  _getAccelerometerData() async {
    try {
      List<double> data = await FlutterAccelerometerPlugin.getAccelerometerData();
      setState(() {
        _accelerometerData = data;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accelerometer Plugin')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Accelerometer Data:'),
            Text('X: ${_accelerometerData[0]}'),
            Text('Y: ${_accelerometerData[1]}'),
            Text('Z: ${_accelerometerData[2]}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getAccelerometerData,
              child: Text('Get Accelerometer Data'),
            ),
          ],
        ),
      ),
    );
  }
}
