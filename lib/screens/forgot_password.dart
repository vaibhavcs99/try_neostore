import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
              RaisedButton(
                  onPressed: () => print('Pressed'),
                  child: Text('Change Password')),
            ],
          ),
        ));
  }
}
