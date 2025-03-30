import 'dart:async';
import 'package:flutter/services.dart';

class FlutterAccelerometerPlugin {
  static const MethodChannel _channel = MethodChannel('flutter_accelerometer_plugin');

  // Function to get accelerometer data
  static Future<List<double>> getAccelerometerData() async {
    final List<dynamic> data = await _channel.invokeMethod('getAccelerometerData');
    return data.cast<double>();
  }
}
