import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/repository/api_services.dart';
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
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: primaryRed2,
        body: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter your email address.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500)),SizedBox(height: 13),
                emailField(),
                MyButton(
                    onPressed: () => _validateInputs(),
                    myText: 'Reset'),
              ],
            ),
          ),
        ));
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
      sendPasswordResetMail(); //same method as authenticate user.
    }
  }

  void sendPasswordResetMail() async {
    var _userEmail = {'email': '$_email'};
    var response = await sendPasswordResetMailService(_userEmail);
    if (response.statusCode == 200) {
      showSnackBar("Email Sent");
    }
  }

  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
