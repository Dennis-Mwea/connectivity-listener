import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'background_listeners_method_channel.dart';

abstract class BackgroundListenersPlatform extends PlatformInterface {
  /// Constructs a BackgroundListenersPlatform.
  BackgroundListenersPlatform() : super(token: _token);

  static final Object _token = Object();

  static BackgroundListenersPlatform _instance = MethodChannelBackgroundListeners();

  /// The default instance of [BackgroundListenersPlatform] to use.
  ///
  /// Defaults to [MethodChannelBackgroundListeners].
  static BackgroundListenersPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BackgroundListenersPlatform] when
  /// they register themselves.
  static set instance(BackgroundListenersPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> hideBanner() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> showBanner() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> isConnected() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
