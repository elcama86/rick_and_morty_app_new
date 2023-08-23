import 'package:flutter/services.dart';

class OrientationSetting {
  static Future<void> setDefaultOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
