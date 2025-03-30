#include "include/flutter_camera_plugin/flutter_camera_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_camera_plugin.h"

void FlutterCameraPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_camera_plugin::FlutterCameraPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
