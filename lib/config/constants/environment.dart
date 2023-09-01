import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String apiUrl =
      dotenv.env['API_URL'] ?? "No está configurado el API_URL";

  static String videoUrl(String language) {
    String url;

    switch (language) {
      case 'es':
        url = dotenv.env['VIDEO_URL_ES'] ?? "No está configurado el VIDEO_URL";
        break;
      case 'en':
        url = dotenv.env['VIDEO_URL_EN'] ?? "No está configurado el VIDEO_URL";
        break;
      default:
        url = dotenv.env['VIDEO_URL_ES'] ?? "No está configurado el VIDEO_URL";
    }

    return url;
  }
}
