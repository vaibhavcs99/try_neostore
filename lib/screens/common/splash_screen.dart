import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 6000), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      if (token == null) {
        Navigator.pushReplacementNamed(context, route_login);
      } else {
        Navigator.pushReplacementNamed(context, route_home_screen,
            arguments: token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: Container(child: Center(child:ClipRRect(borderRadius: BorderRadius.circular(80),child: Image.asset('assets/shopping_gif.gif',width: 200,))),));
    return Scaffold(body: Container(child: Center(child: Text('Loading...'))));
  }
}
