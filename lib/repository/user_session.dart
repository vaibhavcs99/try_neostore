import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  Future<bool> persistToken({@required String accessToken}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString('token', accessToken);
    return result;
  }

  Future<bool> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.remove('token');return result;
  }

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    return (token == null) ? false : true;
    //     if (token == null) {
    //   return false;
    // } else {
    //   return true;
    // }
  }
}
