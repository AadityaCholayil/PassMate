import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  final storage = const FlutterSecureStorage();

  Future<String?> readFromSecureStorage(String key) async {
    return await storage.read(key: key) ?? 'KeyNotFound';
  }

  Future<String?> readFromStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> writeInSecureStorage(
      {required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<void> writeInStorage(
      {required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
