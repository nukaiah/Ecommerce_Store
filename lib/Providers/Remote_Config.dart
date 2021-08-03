import 'package:firebase_remote_config/firebase_remote_config.dart';

class MyConfigures {
  static RemoteConfig _remoteConfig = RemoteConfig.instance;

  static Future<RemoteConfig> contro() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(milliseconds: 5),
        minimumFetchInterval: Duration.zero));
    await _remoteConfig.fetchAndActivate();
    return _remoteConfig;
  }
}
