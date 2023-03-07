// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'background_listeners_platform_interface.dart';

/// A web implementation of the BackgroundListenersPlatform of the BackgroundListeners plugin.
class BackgroundListenersWeb extends BackgroundListenersPlatform {
  /// Constructs a BackgroundListenersWeb
  BackgroundListenersWeb();

  static void registerWith(Registrar registrar) {
    BackgroundListenersPlatform.instance = BackgroundListenersWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<void> hideBanner() async {}

  /// Returns a [String] containing the version of the platform.
  @override
  Future<void> showBanner() async {}

  /// Returns a [String] containing the version of the platform.
  @override
  Future<void> isConnected() async {}
}
