import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'background_listeners_platform_interface.dart';

/// An implementation of [BackgroundListenersPlatform] that uses method channels.
class MethodChannelBackgroundListeners extends BackgroundListenersPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('background_listeners');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}