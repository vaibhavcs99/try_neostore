import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/screens/router.dart';

import 'bloc/login_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => LoginBloc(),
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
