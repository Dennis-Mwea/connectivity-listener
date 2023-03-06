#include "include/background_listeners/background_listeners_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "background_listeners_plugin.h"

void BackgroundListenersPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  background_listeners::BackgroundListenersPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
