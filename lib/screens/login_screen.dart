import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username')),
              TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password')),
              RaisedButton(onPressed:()=> print('Pressed'), child: Text('Login'))
            ],
          ),
        ));
  }
}
