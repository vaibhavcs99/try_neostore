import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/screens/forgot_password.dart';
import 'package:try_neostore/screens/home_screen.dart';
import 'package:try_neostore/screens/login_screen.dart';
import 'package:try_neostore/screens/register_screen.dart';

import 'my_account.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case route_login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
        break;
      case route_register:
        return MaterialPageRoute(
          builder: (_) => Register(),
        );
        break;
      case route_forgot_password:
        return MaterialPageRoute(
          builder: (_) => ForgotPassword(),
        );
        break;
      case route_my_account_details:
        var data = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => MyAccountDetails(data),
        );
        break;
      case route_home_screen:
        var data = settings.arguments as ApiResponse;
        return MaterialPageRoute(
          builder: (_) => HomeScreen(apiResponse: data),
        );
        break;

      default:
    }
  }
}
