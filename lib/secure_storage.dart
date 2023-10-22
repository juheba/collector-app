import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// SecureSotrage is defined as a Singleton.
class SecureStorage {
  late FlutterSecureStorage _storage;
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;

  SecureStorage._internal() {
    _storage = const FlutterSecureStorage();
  }

  void write(String key, String value) {
    _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  Future<Map<String, String>> readKeys(List<String> keys) async {
    List<Future<String?>> futures = keys.map((key) => _storage.read(key: key)).toList();
    List<String?> values = await Future.wait(futures);

    Map<String, String> resultMap = {};
    for (int i = 0; i < keys.length; i++) {
      resultMap[keys[i]] = values[i] ?? '';
    }
    return resultMap;
  }

  Future<void> deleteAll() => _storage.deleteAll();
}
