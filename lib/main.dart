import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/screens/router.dart';

void main() {
  runApp(NeoStore());
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
