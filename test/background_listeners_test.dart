import 'package:background_listeners/background_listeners.dart';
import 'package:background_listeners/background_listeners_method_channel.dart';
import 'package:background_listeners/background_listeners_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBackgroundListenersPlatform with MockPlatformInterfaceMixin implements BackgroundListenersPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> hideBanner() async {}

  @override
  Future<void> showBanner() async {}

  @override
  Future<void> isConnected() async {}
}

void main() {
  final BackgroundListenersPlatform initialPlatform = BackgroundListenersPlatform.instance;

  test('$MethodChannelBackgroundListeners is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBackgroundListeners>());
  });

  test('getPlatformVersion', () async {
    BackgroundListeners backgroundListenersPlugin = BackgroundListeners();
    MockBackgroundListenersPlatform fakePlatform = MockBackgroundListenersPlatform();
    BackgroundListenersPlatform.instance = fakePlatform;

    expect(await backgroundListenersPlugin.getPlatformVersion(), '42');
  });
}
