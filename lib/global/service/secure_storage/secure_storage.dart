import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static final SecureStorage instance = SecureStorage._internal();

  static const String _tokenKey = 'token';

  factory SecureStorage() {
    return instance;
  }
  SecureStorage._internal();

  Future<String?> readToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(_tokenKey);
      if (token == null) {
        return null;
      }
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> writeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<void> removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
