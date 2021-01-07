import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
              TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password')),
              RaisedButton(onPressed:()=> print('Pressed'), child: Text('Login'))
            ],
          ),
        ));
  }
}
