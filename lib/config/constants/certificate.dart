import 'dart:io';
import 'package:flutter/services.dart';

import 'app_initialization.dart';

class Certificate {
  static Future<void> register() async {
    AppInitialization.widgetsBinding;
    ByteData data =
        await PlatformAssetBundle().load('assets/certificate/certificate.pem');
    SecurityContext.defaultContext
        .setTrustedCertificatesBytes(data.buffer.asUint8List());
  }
}
