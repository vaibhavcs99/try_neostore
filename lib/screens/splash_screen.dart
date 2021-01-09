import 'dart:async';

import 'package:flutter/material.dart';
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
    Timer(Duration(seconds: 6),()=>Navigator.pushReplacementNamed(context, route_login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Center(child:ClipRRect(borderRadius: BorderRadius.circular(80),child: Image.asset('assets/shopping_gif.gif',width: 200,))),));
  }
}
