import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:try_neostore/screens/forgot_password.dart';
import 'package:try_neostore/screens/home_screen.dart';
import 'package:try_neostore/screens/login_screen.dart';
import 'package:try_neostore/screens/register_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
        break;
      case '/register':
        return MaterialPageRoute(
          builder: (_) => Register(),
        );
        break;
      case '/forgot_password':
        return MaterialPageRoute(
          builder: (_) => ForgotPassword(),
        );
        break;
      case '/home_screen':
        var data = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => HomeScreen(accessToken: data),
        );
        break;

      default:
    }
  }
}
