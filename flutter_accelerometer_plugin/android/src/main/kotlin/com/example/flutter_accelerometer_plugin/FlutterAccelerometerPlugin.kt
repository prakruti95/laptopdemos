package com.example.flutter_accelerometer_plugin

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterAccelerometerPlugin(private val registrar: Registrar) : MethodChannel.MethodCallHandler {

  private val sensorManager: SensorManager =
    registrar.context().getSystemService(Context.SENSOR_SERVICE) as SensorManager
  private val accelerometer: Sensor? = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
  private var sensorEventListener: SensorEventListener? = null

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method == "getAccelerometerData") {
      sensorEventListener = object : SensorEventListener {
        override fun onSensorChanged(event: SensorEvent?) {
          if (event != null && event.sensor.type == Sensor.TYPE_ACCELEROMETER) {
            val data = floatArrayOf(event.values[0], event.values[1], event.values[2])
            result.success(data.toList()) // Send accelerometer data back to Flutter
          }
        }

        override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
          // Handle sensor accuracy changes if needed
        }
      }
      sensorManager.registerListener(sensorEventListener, accelerometer, SensorManager.SENSOR_DELAY_NORMAL)
    } else {
      result.notImplemented()
    }
  }

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_accelerometer_plugin")
      channel.setMethodCallHandler(FlutterAccelerometerPlugin(registrar))
    }
  }
}
