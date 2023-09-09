
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String _email = 'email';


  static Future<bool> setEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_email, email);
  }

  static Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_email) ?? "";
  }

  static Future removeEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_email);
  }



}