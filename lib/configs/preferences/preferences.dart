// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trevago_app/models/users.dart';

class Preferences {
  late SharedPreferences prefs;

  Future<void> setUserLogin(Users users) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("name", users.name);
    prefs.setString("email", users.email);
    prefs.setString("username", users.username);
    prefs.setString("phone", users.phone);
    prefs.setString("token", users.token);
  }

  Future<Users> getUserProfile() async {
    prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name") ?? "";
    String token = prefs.getString("token") ?? "";
    String email = prefs.getString("email") ?? "";
    String phone = prefs.getString("phone") ?? "";
    String username = prefs.getString("username") ?? "";
    return Users.fromMap({
      "name": name,
      "token": token,
      "email": email,
      "username": username,
      "phone": phone,
    });
  }

  Future<void> deleteUser() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
