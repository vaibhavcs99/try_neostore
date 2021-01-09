import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/utils.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/constants/urls.dart';
import 'package:try_neostore/model/api_response.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title:Text('Login')),
        body: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emailField(),
                passwordField(),
                RaisedButton(
                  onPressed: () => _validateInputs(),
                  child: Text('Login'),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                        text: 'Forgot your Password?',
                        style: TextStyle(color: Colors.blue, fontSize: 20.0),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, route_forgot_password);
                          })),                SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  children: <TextSpan>[TextSpan(text: 'Sign Up',style: TextStyle(color: Colors.blue),recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, route_register);
                    
                          })],
                )),
              ],
            ),
          ),
        ));
  }

  //----------------------------------------------------------------------------------------------------------
//backend code
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      authenticateUser();
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Please Enter all Fields')));
    }
  }

  authenticateUser() async {
    Dio dio = Dio();

    Map<String, dynamic> userDetails = {
      'email': '$_email',
      'password': '$_password'
    };
    FormData formData = FormData.fromMap(userDetails);
    try {
      await dio.post(urlLogin, data: formData).then((value) {
        final apiResponse = apiResponseFromJson(value.data);
        Navigator.pushReplacementNamed(context, route_home_screen, arguments: apiResponse);
        // print(apiResponse.userMsg);
        return null; //FIXME: why null??
      });
    } catch (error) {
      // print(error);
      showSnackBar('Invalid Login Credentials, Try again!');
    }
  }

//-------------------------------------------------------------------------------------------------------------
  //this part contains all the defined UI widget fields.
  emailField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      validator: validateEmail,
      controller: usernameController,
      onSaved: (newValue) {
        _email = newValue;
      },
    );
  }

  passwordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      validator: validatePassword,
      onSaved: (newValue) {
        _password = newValue;
      },
    );
  }

//-------------------------------------------------------------------------------------------------------------
  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
