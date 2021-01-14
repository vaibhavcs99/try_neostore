import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:try_neostore/bloc/authentication_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/Utils/router.dart';
import 'package:try_neostore/repository/user_session.dart';

import 'bloc/login_bloc.dart';
import 'bloc/register_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserSession userSession= UserSession();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthenticationBloc(userSession: userSession)),
      BlocProvider(create: (_) => LoginBloc(authenticationBloc:BlocProvider.of<AuthenticationBloc>(_))),
      BlocProvider(create: (_) => RegisterBloc()),
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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: route_splash_screen,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
