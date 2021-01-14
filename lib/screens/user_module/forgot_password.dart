import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/network/api_services.dart';

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
    return Scaffold(
      
        key: _scaffoldKey,
        appBar: AppBar(),
        body: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter your email address below to to reset password'),
                emailField(),
                RaisedButton(
                    onPressed: () => _validateInputs(),
                    child: Text('Change Password')),
              ],
            ),
          ),
        ));
  }

  emailField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      validator: validateEmail,
      onSaved: (newValue) {
        _email = newValue.trim();
      },
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      sendPasswordResetMail(); //same method as authenticate user.
    }
  }

  void sendPasswordResetMail() async {
    var _userEmail = {'email': '$_email'};
    var resultReceived = await sendPasswordResetMailService(_userEmail);

    showSnackBar("resultReceived");
  }
  // void sendPasswordResetMail() async {
  //   var dio = Dio();
  //   var _userEmail = {'email': '$_email'};

  //   FormData formData = FormData.fromMap(_userEmail);

  //   try {
  //     await dio.post(urlForgotPassword, data: formData).then((value) async {
  //       showSnackBar('Password reset email is sent!');
  //     });
  //   } on DioError catch (dioError) {
  //     if (dioError.response.statusCode == 404) showSnackBar('Email not found');
  //   } catch (e) {}
  // }

  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
