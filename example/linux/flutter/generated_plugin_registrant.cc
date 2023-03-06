//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <background_listeners/background_listeners_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) background_listeners_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BackgroundListenersPlugin");
  background_listeners_plugin_register_with_registrar(background_listeners_registrar);
}
