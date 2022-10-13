import 'package:base_project/global/model/user/model_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage instance = SecureStorage._internal();

  static const String _tokenKey = 'token';
  static const String _meKey = 'me';

  late FlutterSecureStorage _storage;
  factory SecureStorage() {
    return instance;
  }
  SecureStorage._internal() {
    _storage = const FlutterSecureStorage();
  }

  Future<String?> readToken() async {
    String? token = await _storage.read(key: _tokenKey);
    if (token == null) {
      return null;
    }
    return token;
  }

  Future<void> writeToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> removeToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<ModelUser> readMe() async {
    String? meInfo = await _storage.read(key: _meKey);
    return ModelUser.fromJson(meInfo!);
  }

  Future<void> writeMe(ModelUser me) async {
    String meInfo = me.toJson();
    await _storage.write(key: _meKey, value: meInfo);
  }

  Future<void> removeMe() async {
    await _storage.delete(key: _meKey);
  }

  Future<void> removeAll() async {
    await _storage.deleteAll();
  }
}
