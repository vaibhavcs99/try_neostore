import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/bloc/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/Utils/router.dart';
import 'package:try_neostore/repository/user_session.dart';

import 'bloc/authBloc/authentication_bloc.dart';
import 'bloc/loginBloc/login_bloc.dart';
import 'bloc/registerBloc/register_bloc.dart';

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
