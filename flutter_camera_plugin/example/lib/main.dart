
import 'package:flutter/material.dart';
import 'package:flutter_camera_plugin/flutter_camera_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraHome(),
    );
  }
}

class CameraHome extends StatelessWidget {
  void openCamera() async {
    final result = await FlutterCameraPlugin.openCamera();
    print(result); // Output from the native platform
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Camera Plugin'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: openCamera,
          child: Text('Open Camera'),
        ),
      ),
    );
  }
}
        