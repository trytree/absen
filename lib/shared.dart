import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesHelper {

  static Future<String> getID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('userID');
  }

  static Future<bool> setID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString('userID', value);
  }

  static Future<bool> delID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.remove('userID');
  }
}