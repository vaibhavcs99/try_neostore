import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/utils.dart';

class EditAccountDetails extends StatefulWidget {
  @override
  _EditAccountDetailsState createState() => _EditAccountDetailsState();
}

class _EditAccountDetailsState extends State<EditAccountDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _confirmPassword;
  int _phoneNumber;
  String _gender = 'M';

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  firstNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'First Name'),
      validator: validateName,
      onSaved: (newValue) {
        _firstName = newValue.trim();
      },
    );
  }

  lastNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Last Name'),
      validator: validateName,
      onSaved: (newValue) {
        _lastName = newValue.trim();
      },
    );
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

  passwordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      validator: validatePassword,
      onSaved: (newValue) {
        _password = newValue.trim();
      },
    );
  }

  confirmPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Confirm Password'),
      validator: validatePassword,
      onSaved: (newValue) {
        _confirmPassword = newValue.trim();
      },
    );
  }

  phoneNumberField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Phone Number'),
      validator: validatePhoneNumber,
      onSaved: (newValue) {
        _phoneNumber = int.parse(newValue.trim());
      },
    );
  }

//-------------------------------------------------------------------------------------------------------------
  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
