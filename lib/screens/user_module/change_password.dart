
import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/network/api_services.dart';

class ChangePassword extends StatefulWidget {
  final String accessToken;

  const ChangePassword(
 {
    Key key, this.accessToken,
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
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Change Password'),
          
        ),
        body: Center(
          child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(children: [
                SizedBox(height: 16),
                currentPasswordField(),
                SizedBox(height: 8),
                newPasswordField(),
                SizedBox(height: 8),
                confirmNewPasswordField(),
                SizedBox(height: 8),
                FlatButton(
                    onPressed: _validateInputs, child: Text('Change Password'))
              ])),
        ));
  }

  currentPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Current Password'),
      validator: validatePassword,
      onSaved: (newValue) {
        _currentPassword = newValue.trim();
      },
    );
  }

  newPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      validator: validatePassword,
      onSaved: (newValue) {
        _newPassword = newValue.trim();
      },
    );
  }

  confirmNewPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      validator: validatePassword,
      onSaved: (newValue) {
        _confirmNewPassword = newValue.trim();
      },
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      changePassword(); //same method as authenticate user.
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Please Enter all Fields')));
    }
  }

  void changePassword() async {
    Map<String, dynamic> _passwordDetails = {
      'old_password': '$_currentPassword',
      'password': '$_newPassword',
      'confirm_password': '$_confirmNewPassword',
    };

    var response = await changePasswordService(
        widget.accessToken, _passwordDetails);

     if (response.statusCode == 200) {
      showSnackBar('Password Changed successfully');
    }
  }

  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
