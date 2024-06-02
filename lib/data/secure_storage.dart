import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// SecureStorage is defined as a Singleton.
class SecureStorage {
  factory SecureStorage() => _instance;

  SecureStorage._internal() {
    _storage = const FlutterSecureStorage(
      mOptions: MacOsOptions(
        synchronizable: true,
      ),
    );
  }

  late FlutterSecureStorage _storage;
  static final SecureStorage _instance = SecureStorage._internal();

  Future<void> write(String key, String value) async => _storage.write(key: key, value: value);

  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  Future<Map<String, String>> readKeys(List<String> keys) async {
    final futures = keys.map((key) => _storage.read(key: key)).toList();
    final values = await Future.wait(futures);

    final resultMap = <String, String>{};
    for (var i = 0; i < keys.length; i++) {
      resultMap[keys[i]] = values[i] ?? '';
    }
    return resultMap;
  }

  Future<void> deleteAll() => _storage.deleteAll();
}
