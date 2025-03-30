
import 'dart:async';
import 'package:flutter/services.dart';

class FlutterCameraPlugin {
  static const MethodChannel _channel = MethodChannel('flutter_camera_plugin');

  static Future<String?> openCamera() async {
    final String? result = await _channel.invokeMethod('openCamera');
    return result;
  }
}
        