#include "include/accelerometer_plugin/accelerometer_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "accelerometer_plugin.h"

void AccelerometerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  accelerometer_plugin::AccelerometerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
