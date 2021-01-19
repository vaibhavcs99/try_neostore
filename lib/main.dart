import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/bloc/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/Utils/router.dart';
import 'package:try_neostore/repository/user_session.dart';

import 'bloc/address_bloc/address_bloc.dart';
import 'bloc/auth_bloc/authentication_bloc.dart';
import 'bloc/cart_list_bloc/cart_list_bloc.dart';
import 'bloc/drawer_bloc/drawer_bloc.dart';
import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/order_details_bloc/order_details_bloc.dart';
import 'bloc/order_list_bloc/order_list_bloc.dart';
import 'bloc/product_details_bloc/product_details_bloc.dart';
import 'bloc/product_list_bloc/product_list_bloc.dart';
import 'bloc/register_bloc/register_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserSession userSession = UserSession();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthenticationBloc(userSession: userSession)),
      BlocProvider(
          create: (_) => LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(_))),
      BlocProvider(
          create: (_) => RegisterBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(_))),
      BlocProvider(create: (_) => ForgotPasswordBloc()),
      BlocProvider(create: (_) => ProductListBloc()),
      BlocProvider(create: (_) => ProductDetailsBloc()),
      BlocProvider(create: (_) => CartListBloc()),
      BlocProvider(create: (_) => AddressBloc()),
      BlocProvider(create: (_) => OrderListBloc()),
      BlocProvider(create: (_) => OrderDetailsBloc()),
      BlocProvider(
          create: (_) => DrawerBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(_)))
    ],
    child: NeoStore(),
  ));
}

class NeoStore extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryRed2,
        scaffoldBackgroundColor: colorGreyBackground,
        fontFamily: 'Gotham',
        hintColor: Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: route_splash_screen,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
