import 'background_listeners_platform_interface.dart';

class BackgroundListeners {
  Future<String?> getPlatformVersion() => BackgroundListenersPlatform.instance.getPlatformVersion();

  Future<void> hideBanner() => BackgroundListenersPlatform.instance.hideBanner();

  Future<void> showBanner() => BackgroundListenersPlatform.instance.showBanner();
}
