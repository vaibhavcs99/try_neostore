
import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/network/api_services.dart';

class ChangePassword extends StatefulWidget {
  final ApiResponse _apiResponse;

  const ChangePassword(
    this._apiResponse, {
    Key key,
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

    String receivedMessage = await changePasswordService(
        widget._apiResponse.data.accessToken, _passwordDetails);

    showSnackBar(receivedMessage);
  }
  // void changePassword() async {
  //   var dio = Dio();

  //   dio.options.headers['access_token'] = widget._apiResponse.data.accessToken;

  //   Map<String, dynamic> passwordDetails = {
  //     'old_password': '$_currentPassword',
  //     'password': '$_newPassword',
  //     'confirm_password': '$_confirmNewPassword',
  //   };

  //   FormData _formData = FormData.fromMap(passwordDetails);

  //   try {
  //     await dio.post(urlChangePassword, data: _formData).then((value) async {
  //       showSnackBar('Password Changed');
  //     });
  //   } on DioError catch (dioError) {
  //     showSnackBar(dioError.message.toString());
  //   } catch (e) {}
  // }

  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
