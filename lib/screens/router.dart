import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/product_list_model.dart';
import 'package:try_neostore/screens/product_details.dart';
import 'package:try_neostore/screens/products_list.dart';
import 'package:try_neostore/screens/user_module/forgot_password.dart';
import 'package:try_neostore/screens/home_screen.dart';
import 'package:try_neostore/screens/user_module/login_screen.dart';
import 'package:try_neostore/screens/user_module/register_screen.dart';
import 'package:try_neostore/screens/splash_screen.dart';

import 'user_module/change_password.dart';
import 'user_module/edit_account_details.dart';
import 'user_module/my_account.dart';

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
        var data = settings.arguments as ApiResponse;
        return MaterialPageRoute(
          builder: (_) => MyAccountDetails(data),
        );
        break;
      case route_edit_account_details:
        var data = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => EditAccountDetails(data),
        );
        break;
      case route_change_password:
        var data = settings.arguments as ApiResponse;
        return MaterialPageRoute(
          builder: (_) => ChangePassword(data),
        );
        break;

//*****************************************************************************************************
      case route_home_screen:
        var data = settings.arguments as ApiResponse;
        return MaterialPageRoute(
          builder: (_) => HomeScreen(data),
        );
        break;
      case route_splash_screen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
        break;
      case route_product_list:
        int index = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => ProductList(index: index),
        );
        break;
      case route_product_details:
        var productInfo = settings.arguments as Datum;
        return MaterialPageRoute(
          builder: (_) => ProductDetails(productInfo: productInfo,),
        );
        break;

      default:
    }
  }
}
