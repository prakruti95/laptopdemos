import 'package:flutter/material.dart';
import 'package:accelerometer_plugin/accelerometer_plugin.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: ShakeDetectionScreen(),
    );
  }
}

class ShakeDetectionScreen extends StatefulWidget {
  @override
  _ShakeDetectionScreenState createState() => _ShakeDetectionScreenState();
}

class _ShakeDetectionScreenState extends State<ShakeDetectionScreen> {
  Color _backgroundColor = Colors.white;
  String _message = "No Shake Detected";

  @override
  void initState() {
    super.initState();
    AccelerometerPlugin.sensorStream.listen((event) {
      if (event is String && event == "Shake detected!") {
        setState(() {
          _backgroundColor = Colors.green; // Change background color to green
          _message = "Welcome to World"; // Update message
        });

        // Reset after 2 seconds
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _backgroundColor = Colors.white; // Reset background color
            _message = "No Shake Detected"; // Reset message
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(title: const Text('Shake Detection')),
      body: Center(
        child: Text(
          _message,
          style: const TextStyle(fontSize: 24, color: Colors.blueAccent),
        ),
      ),
    );
  }
}
