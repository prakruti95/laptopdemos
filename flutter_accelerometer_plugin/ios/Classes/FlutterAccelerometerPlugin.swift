import Flutter
import UIKit
import CoreMotion

public class SwiftFlutterAccelerometerPlugin: NSObject, FlutterPlugin {
    var motionManager: CMMotionManager?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_accelerometer_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterAccelerometerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getAccelerometerData" {
            if motionManager == nil {
                motionManager = CMMotionManager()
                motionManager?.accelerometerUpdateInterval = 1.0 / 60.0
                motionManager?.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
                    if let accelerometerData = data {
                        let accelerometerValues: [Float] = [Float(accelerometerData.acceleration.x),
                                                             Float(accelerometerData.acceleration.y),
                                                             Float(accelerometerData.acceleration.z)]
                        result(accelerometerValues)
                    } else {
                        result(FlutterError(code: "UNAVAILABLE", message: "Accelerometer not available", details: nil))
                    }
                }
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
