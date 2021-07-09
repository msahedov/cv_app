import 'package:shared_preferences/shared_preferences.dart';

const String serverIP = "ussalar.xyz";

class Auth {
  SharedPreferences _prefs;

  Future<bool> login({String name, int uid, String phone}) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('name', name);
    await _prefs.setInt('uid', uid);
    await _prefs.setString('phone', phone);
    return await _prefs.setBool("isLoggedIn", true);
    
  }

  Future<bool> logout() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.remove("name");
    await _prefs.remove("uid");
    await _prefs.remove("phone");
    return await _prefs.setBool("isLoggedIn", false);
    
  }

  Future<bool> setToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.setString('token', token);
  }

  Future<String> getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<bool> remove() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.remove('token');
  }
}
