import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/data_class.dart';
import '../constants/constants.dart';
import '../screens/home_screen.dart';
import '../screens/order/address_list.dart';
import '../screens/order/cart_list.dart';
import '../screens/order/enter_address.dart';
import '../screens/order/order_details.dart';
import '../screens/order/order_list.dart';
import '../screens/product/product_details.dart';
import '../screens/product/products_list.dart';
import '../screens/user_module/change_password.dart';
import '../screens/user_module/edit_account_details.dart';
import '../screens/user_module/forgot_password.dart';
import '../screens/user_module/login_screen.dart';
import '../screens/user_module/my_account.dart';
import '../screens/user_module/register_screen.dart';
import '../screens/widgets/splash_screen.dart';

class AppRouter {
  // ignore: missing_return
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
        var accessToken = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MyAccountDetails(accessToken: accessToken),
        );
        break;
      case route_edit_account_details:
        ScreenParameters parameters = settings.arguments as ScreenParameters;
        String accessToken = parameters.parameter1 as String;
        String profilePic = parameters.parameter2 as String;
        return MaterialPageRoute(
          builder: (_) => EditAccountDetails(
              accessToken: accessToken,profilePic: profilePic),
        );
        break;
      case route_change_password:
        var accessToken = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ChangePassword(accessToken: accessToken),
        );
        break;

//*****************************************************************************************************
      case route_home_screen:
        var accessToken = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => HomeScreen(accessToken: accessToken),
        );
        break;
      case route_splash_screen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
        break;
      case route_product_list:
        ScreenParameters parameters = settings.arguments as ScreenParameters;
        String accessToken = parameters.parameter2 as String;

        return MaterialPageRoute(
          builder: (_) => ProductList(
            index: parameters.parameter1,
            accessToken: accessToken,
          ),
        );
        break;
      case route_product_details:
        ScreenParameters parameters = settings.arguments as ScreenParameters;
        int productId = parameters.parameter1 as int;
        String accessToken = parameters.parameter2 as String;
        String productName = parameters.parameter3 as String;

        return MaterialPageRoute(
          builder: (_) => ProductDetails(
              productId: productId,
              accessToken: accessToken,
              productName: productName),
        );
        break;
//*****************************************************************************************************

      case route_cart_list:
        String accessToken = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CartList(
            accessToken: accessToken,
          ),
        );
        break;
      case route_enter_address:
        String accessToken = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => EnterAddress(accessToken: accessToken),
        );
        break;
      case route_address_list:
        String accessToken = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AddressList(accessToken: accessToken),
        );
        break;
      case route_order_list:
        String accessToken = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MyOrders(accessToken: accessToken),
        );
        break;
      case route_order_details:
        ScreenParameters parameters = settings.arguments as ScreenParameters;

        int orderId = parameters.parameter1 as int;
        String accessToken = parameters.parameter2 as String;
        return MaterialPageRoute(
          builder: (_) => OrderDetails(
            orderId: orderId,
            accessToken: accessToken,
          ),
        );
        break;

      default:
      //TODO: IMPLEMENT ERROR PAGE...
    }
  }
}
