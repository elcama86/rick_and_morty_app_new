import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_and_morty_app/features/shared/infrastructure/services/key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  T? getValue<T>(String key) {
    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
      case bool:
        return prefs.getBool(key) as T?;
      case double:
        return prefs.getDouble(key) as T?;
      case String:
        return prefs.getString(key) as T?;
      case const (List<String>):
        return prefs.getStringList(key) as T?;
      default:
        throw UnimplementedError(
            'No configurada la obtención para el tipo ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeValue(String key) async {
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    switch (T) {
      case int:
        await prefs.setInt(key, value as int);
        break;
      case bool:
        await prefs.setBool(key, value as bool);
        break;
      case double:
        await prefs.setDouble(key, value as double);
        break;
      case String:
        await prefs.setString(key, value as String);
        break;
      case const (List<String>):
        await prefs.setStringList(key, value as List<String>);
        break;
      default:
        throw UnimplementedError(
            'No configurado el establecimiento para el tipo ${T.runtimeType}');
    }
  }
}
