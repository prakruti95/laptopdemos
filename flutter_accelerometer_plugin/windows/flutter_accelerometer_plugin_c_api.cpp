#include "include/flutter_accelerometer_plugin/flutter_accelerometer_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_accelerometer_plugin.h"

void FlutterAccelerometerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_accelerometer_plugin::FlutterAccelerometerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
