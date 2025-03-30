package com.example.accelerometer_plugin

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import kotlin.math.sqrt

class AccelerometerPlugin : FlutterPlugin, EventChannel.StreamHandler {
    private lateinit var eventChannel: EventChannel
    private var sensorManager: SensorManager? = null
    private var accelerometer: Sensor? = null
    private var sensorEventListener: SensorEventListener? = null
    private var lastShakeTime: Long = 0

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        val context = binding.applicationContext
        sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        accelerometer = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

        eventChannel = EventChannel(binding.binaryMessenger, "accelerometer_plugin")
        eventChannel.setStreamHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        eventChannel.setStreamHandler(null)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sensorEventListener = object : SensorEventListener {
            override fun onSensorChanged(event: SensorEvent) {
                if (event.sensor.type == Sensor.TYPE_ACCELEROMETER) {
                    val x = event.values[0]
                    val y = event.values[1]
                    val z = event.values[2]

                    // Calculate shake threshold
                    val gForce = sqrt((x * x + y * y + z * z).toDouble()) / SensorManager.GRAVITY_EARTH
                    if (gForce > 2.7) { // Threshold for shake detection
                        val currentTime = System.currentTimeMillis()
                        if (currentTime - lastShakeTime > 500) { // Minimum shake interval (500ms)
                            lastShakeTime = currentTime
                            events?.success("Shake detected!") // Notify Flutter about shake
                        }
                    }
                }
            }

            override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
        }
        sensorManager?.registerListener(sensorEventListener, accelerometer, SensorManager.SENSOR_DELAY_NORMAL)
    }

    override fun onCancel(arguments: Any?) {
        sensorManager?.unregisterListener(sensorEventListener)
    }
}
