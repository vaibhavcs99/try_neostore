import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/validators.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import '../../constants/constants.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    bool keyboardIsClosed = MediaQuery.of(context).viewInsets.bottom == 0;
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccessful) {
            Navigator.pushReplacementNamed(context, route_home_screen,
                arguments: state.accessToken);
          }
          if (state is LoginFailed) {
            showSnackBar('${state.error}');
          }
        },
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: primaryRed2,
            floatingActionButton: Visibility(
              visible: keyboardIsClosed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 5.0.w),
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                  FloatingActionButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, route_register),
                    backgroundColor: primaryRed1,
                    shape: RoundedRectangleBorder(),
                    child: Icon(Icons.add, size: 50),
                  ),
                ],
              ),
            ),
            body: Center(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(
                  children: [
                    SizedBox(height: 13.0.h),
                    Center(
                      child: Text('NeoSTORE',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    SizedBox(height: 6.0.h),
                    emailField(),
                    passwordField(),
                    MyButton(
                        onPressed: () => _validateInputs(), myText: 'Login'),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Center(
                      child: RichText(
                          text: TextSpan(
                              text: 'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0.sp,
                                  fontWeight: FontWeight.w500),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, route_forgot_password);
                                })),
                    ),
                    // SizedBox(height: 15.0.h),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 33.0),
                    //   child: Text(
                    //     "Don't have an account? ",
                    //     style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 20.0,
                    //         fontWeight: FontWeight.w500),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )));
  }

  //----------------------------------------------------------------------------------------------------------
//backend code
  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      BlocProvider.of<LoginBloc>(context)
          .add(OnLoginButtonPressed(email: _email, password: _password));
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Please Enter all Fields')));
    }
  }

//-------------------------------------------------------------------------------------------------------------
  //this part contains all the defined UI widget fields.
  emailField() {
    return MyTextFormField(
      myLabelText: 'Email',
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      myIcon: Icon(
        Icons.person,
        color: Colors.white,
      ),
      onSaved: (newValue) {
        _email = newValue;
      },
    );
  }

  passwordField() {
    return MyTextFormField(
      myIcon: Icon(Icons.lock, color: Colors.white),
      obscureText: true,
      myLabelText: 'Password',
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
