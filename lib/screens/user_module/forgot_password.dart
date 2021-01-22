import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/bloc/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/screens/widgets/my_button.dart';
import 'package:try_neostore/screens/widgets/my_text_form_field.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccessful) {
          showSnackBar('Email Sent Successfully');
        }
        if (state is ForgotPasswordUnsuccessful) {
          showSnackBar(state.error);
        }
      },
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: primaryRed2,
          body: Center(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildEmailText(),
                  SizedBox(height: 3.0.h),
                  emailField(),
                  MyButton(onPressed: () => _validateInputs(), myText: 'Reset'),
                ],
              ),
            ),
          )),
    );
  }

  Text buildEmailText() {
    return Text('Enter your email address.',
        style: TextStyle(
            color: Colors.white, fontSize: 17.0.sp, fontWeight: FontWeight.w500));
  }

  emailField() {
    return MyTextFormField(
      myLabelText: 'Email',
      myIcon: Icon(Icons.person, color: Colors.white),
      validator: validateEmail,
      onSaved: (newValue) {
        _email = newValue.trim();
      },
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      BlocProvider.of<ForgotPasswordBloc>(context)
          .add(OnResetButtonPresssed(email: _email));
    }
  }

  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
