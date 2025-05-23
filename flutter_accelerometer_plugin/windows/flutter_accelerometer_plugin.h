#ifndef FLUTTER_PLUGIN_FLUTTER_ACCELEROMETER_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_ACCELEROMETER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_accelerometer_plugin {

class FlutterAccelerometerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterAccelerometerPlugin();

  virtual ~FlutterAccelerometerPlugin();

  // Disallow copy and assign.
  FlutterAccelerometerPlugin(const FlutterAccelerometerPlugin&) = delete;
  FlutterAccelerometerPlugin& operator=(const FlutterAccelerometerPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_accelerometer_plugin

#endif  // FLUTTER_PLUGIN_FLUTTER_ACCELEROMETER_PLUGIN_H_
