import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _lastCityKey = 'last_city';

  Future<void> saveLastCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastCityKey, city);
  }

  Future<String?> getLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastCityKey);
  }
}
