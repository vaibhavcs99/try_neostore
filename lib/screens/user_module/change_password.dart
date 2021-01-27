import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Utils/validators.dart';
import '../../bloc/change_password/change_password_bloc.dart';
import '../../constants/constants.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_form_field.dart';

class ChangePassword extends StatefulWidget {
  final String accessToken;

  const ChangePassword({
    Key key,
    this.accessToken,
  }) : super(key: key);
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _currentPassword;
  String _newPassword;
  String _confirmNewPassword;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessful) {
          showSnackBar('Password changed successfully.');
        }
      },
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: primaryRed2,
          appBar: AppBar(
            title: Text('Change Password'),
          ),
          body: Center(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: ListView(children: [
                  SizedBox(height: 24),
                  currentPasswordField(),
                  SizedBox(height: 8),
                  newPasswordField(),
                  SizedBox(height: 8),
                  confirmNewPasswordField(),
                  SizedBox(height: 8),
                  MyButton(
                      onPressed: _validateInputs, myText: 'Change Password')
                ])),
          )),
    );
  }

  currentPasswordField() {
    return MyTextFormField(
      myIcon: Icon(Icons.lock, color: Colors.white),
      obscureText: true,
      myLabelText: 'Current Password',
      validator: validatePassword,
      onSaved: (newValue) {
        _currentPassword = newValue.trim();
      },
    );
  }

  newPasswordField() {
    return MyTextFormField(
      myIcon: Icon(Icons.lock, color: Colors.white),
      obscureText: true,
      myLabelText: 'Password',
      validator: validatePassword,
      onSaved: (newValue) {
        _newPassword = newValue.trim();
      },
    );
  }

  confirmNewPasswordField() {
    return MyTextFormField(
      myIcon: Icon(Icons.lock, color: Colors.white),
      obscureText: true,
      myLabelText: 'Confirm New Password',
      validator: validatePassword,
      onSaved: (newValue) {
        _confirmNewPassword = newValue.trim();
      },
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      BlocProvider.of<ChangePasswordBloc>(context).add(OnChangePasswordPressed(
        accessToken: widget.accessToken,
        confirmNewPassword: _confirmNewPassword,
        currentPassword: _currentPassword,
        newPassword: _newPassword,
      ));
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Please Enter all Fields')));
    }
  }

  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
