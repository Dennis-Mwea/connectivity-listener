
import 'background_listeners_platform_interface.dart';

class BackgroundListeners {
  Future<String?> getPlatformVersion() {
    return BackgroundListenersPlatform.instance.getPlatformVersion();
  }
}
