//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <accelerometer_plugin/accelerometer_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) accelerometer_plugin_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AccelerometerPlugin");
  accelerometer_plugin_register_with_registrar(accelerometer_plugin_registrar);
}
