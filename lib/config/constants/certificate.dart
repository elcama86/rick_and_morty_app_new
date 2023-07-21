import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Certificate {
  static register() async {
    WidgetsFlutterBinding.ensureInitialized();
    ByteData data =
        await PlatformAssetBundle().load('assets/certificate/certificate.pem');
    SecurityContext.defaultContext
        .setTrustedCertificatesBytes(data.buffer.asUint8List());
  }
}
