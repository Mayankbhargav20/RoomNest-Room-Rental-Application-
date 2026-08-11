import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String tokenKey = "jwt_token";

  // Save JWT
  Future<void> saveToken(String token) async {
    await _storage.write(key: tokenKey, value: token);
  }

  // Get JWT
  Future<String?> getToken() async {
    return await _storage.read(key: tokenKey);
  }

  // Delete JWT
  Future<void> deleteToken() async {
    await _storage.delete(key: tokenKey);
  }
}
