import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:background_listeners/background_listeners_method_channel.dart';

void main() {
  MethodChannelBackgroundListeners platform = MethodChannelBackgroundListeners();
  const MethodChannel channel = MethodChannel('background_listeners');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
