import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/data_class.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/product_list_model.dart';
import 'package:try_neostore/screens/cart_list.dart';
import 'package:try_neostore/screens/order/enter_address.dart';
import 'package:try_neostore/screens/order/order_details.dart';
import 'package:try_neostore/screens/order/order_list.dart';
import 'package:try_neostore/screens/product/product_details.dart';
import 'package:try_neostore/screens/product/products_list.dart';
import 'package:try_neostore/screens/user_module/forgot_password.dart';
import 'package:try_neostore/screens/home_screen.dart';
import 'package:try_neostore/screens/user_module/login_screen.dart';
import 'package:try_neostore/screens/user_module/register_screen.dart';
import 'package:try_neostore/screens/common/splash_screen.dart';

import '../screens/user_module/change_password.dart';
import '../screens/user_module/edit_account_details.dart';
import '../screens/user_module/my_account.dart';

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
        ScreenParameters parameters = settings.arguments as ScreenParameters;
        return MaterialPageRoute(
          builder: (_) => ProductList(
            index: parameters.parameter1,
            apiResponse: parameters.parameter2,
          ),
        );
        break;
      case route_product_details:
        ScreenParameters parameters = settings.arguments as ScreenParameters;
        Datum productInfo = parameters.parameter1 as Datum;
        ApiResponse apiResponse = parameters.parameter2 as ApiResponse;

        return MaterialPageRoute(
          builder: (_) => ProductDetails(
            productInfo: productInfo,
            apiResponse: apiResponse,
          ),
        );
        break;
//*****************************************************************************************************

      case route_cart_list:
        ApiResponse apiResponse = settings.arguments as ApiResponse;
        return MaterialPageRoute(
          builder: (_) => CartList(
            apiResponse: apiResponse,
          ),
        );
        break;
      case route_enter_address:
        ApiResponse apiResponse = settings.arguments as ApiResponse;
        return MaterialPageRoute(
          builder: (_) => EnterAddress(apiResponse: apiResponse),
        );
        break;
      case route_order_list:
        ApiResponse apiResponse = settings.arguments as ApiResponse;
        return MaterialPageRoute(
          builder: (_) => MyOrders(apiResponse: apiResponse),
        );
        break;
      case route_order_details:
        ScreenParameters parameters = settings.arguments as ScreenParameters;

        int orderId = parameters.parameter1 as int;
        ApiResponse apiResponse = parameters.parameter2 as ApiResponse;
        return MaterialPageRoute(
          builder: (_) => OrderDetails(
            orderId: orderId,
            apiResponse: apiResponse,
          ),
        );
        break;

      default:
    }
  }
}
