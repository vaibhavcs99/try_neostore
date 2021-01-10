import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/network/api_services.dart';

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
        appBar: AppBar(title: Text('Login')),
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
                          })),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, route_register);
                          })
                  ],
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

  void authenticateUser() async {
    Map<String, dynamic> _userDetails = {
      'email': '$_email',
      'password': '$_password'
    };

    var _apiResponseReceived = await authenticateUserService(_userDetails);
    if (_apiResponseReceived is String) {
      showSnackBar(_apiResponseReceived);
    } else if (_apiResponseReceived is ApiResponse) {
      Navigator.popAndPushNamed(context, route_home_screen,
          arguments: _apiResponseReceived);
    } else {
      showSnackBar('Something is wrong!');
    }
    
  }

//-------------------------------------------------------------------------------------------------------------
  //this part contains all the defined UI widget fields.
  emailField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
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
      keyboardType: TextInputType.visiblePassword,
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
