import 'dart:async';
import 'package:flutter/services.dart';

class AccelerometerPlugin {
  static const EventChannel _eventChannel =
      EventChannel('accelerometer_plugin');

  static Stream<dynamic>? _sensorStream;

  static Stream<dynamic> get sensorStream {
    _sensorStream ??= _eventChannel.receiveBroadcastStream();
    return _sensorStream!;
  }
}
