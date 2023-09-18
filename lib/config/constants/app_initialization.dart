import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rick_and_morty_app/features/auth/auth.dart';
import 'package:rick_and_morty_app/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

import '../helpers/human_formats.dart';
import 'constants.dart';

class AppInitialization {
  static Future<void> initialize() async {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await Certificate.register();
    await OrientationSetting.setDefaultOrientation();
    await Environment.initEnvironment();
    await AuthBloc.initializeServices();
    await KeyValueStorageServiceImpl.init();
    HumanFormats.initializeDates();
  }

  static WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
}
