#ifndef FLUTTER_PLUGIN_BACKGROUND_LISTENERS_PLUGIN_H_
#define FLUTTER_PLUGIN_BACKGROUND_LISTENERS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace background_listeners {

class BackgroundListenersPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BackgroundListenersPlugin();

  virtual ~BackgroundListenersPlugin();

  // Disallow copy and assign.
  BackgroundListenersPlugin(const BackgroundListenersPlugin&) = delete;
  BackgroundListenersPlugin& operator=(const BackgroundListenersPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace background_listeners

#endif  // FLUTTER_PLUGIN_BACKGROUND_LISTENERS_PLUGIN_H_
