package com.example.flutter_accelerometer_plugin

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar

class MainActivity: MethodChannel.MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_accelerometer_plugin")
            channel.setMethodCallHandler(FlutterAccelerometerPlugin())
        }
    }
}
