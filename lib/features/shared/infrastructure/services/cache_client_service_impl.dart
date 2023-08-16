import 'package:rick_and_morty_app/features/shared/infrastructure/services/cache_client_service.dart';

class CacheClientServiceImpl extends CacheClientService {
  final Map<String, Object> _cache;

  CacheClientServiceImpl() : _cache = <String, Object>{};

  @override
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }

  @override
  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }
}
