import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  writeSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    String? value = await _storage.read(key: key);
    return value;
  }

  deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }
}
