#ifndef FLUTTER_PLUGIN_ACCELEROMETER_PLUGIN_H_
#define FLUTTER_PLUGIN_ACCELEROMETER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace accelerometer_plugin {

class AccelerometerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  AccelerometerPlugin();

  virtual ~AccelerometerPlugin();

  // Disallow copy and assign.
  AccelerometerPlugin(const AccelerometerPlugin&) = delete;
  AccelerometerPlugin& operator=(const AccelerometerPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace accelerometer_plugin

#endif  // FLUTTER_PLUGIN_ACCELEROMETER_PLUGIN_H_
