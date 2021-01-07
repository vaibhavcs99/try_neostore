import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/utils.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _autoValidate = false;

  var maleCheckBox = true;
  var femaleCheckBox = false;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var gender = 'ok';

  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _confirmPassword;
  String _phoneNumber;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              firstNameField(),
              lastNameField(),
              emailField(),
              passwordField(),
              confirmPasswordField(),
              buildGender(),
              phoneNumberField(),
              RaisedButton(
                  onPressed: () => _validateInputs(), child: Text('Register')),
            ],
          ),
        ),
      ),
    );
  }

  Row buildGender() {
    return Row(
      children: [
        Expanded(flex: 3, child: Text('Gender')),
        Expanded(
          flex: 1,
          child: Checkbox(
            value: maleCheckBox,
            onChanged: (value) {
              gender = 'Male';
              setState(() {
                gender = 'Male';
                maleCheckBox = value;
                femaleCheckBox = !value;
              });
            },
          ),
        ),
        Expanded(flex: 1, child: Text('Male')),
        Expanded(
          flex: 1,
          child: Checkbox(
            value: femaleCheckBox,
            onChanged: (value) {
              setState(() {
                gender = 'Female';
                femaleCheckBox = value;
                maleCheckBox = !value;
              });
            },
          ),
        ),
        Expanded(flex: 1, child: Text('Female')),
      ],
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please Enter all Fields')));
    }
  }

  firstNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'First Name'),
      validator: validateName,
      onSaved: (newValue) {
        _firstName = newValue;
      },
    );
  }

  lastNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Last Name'),
      validator: validateName,
      onSaved: (newValue) {
        _lastName = newValue;
      },
    );
  }

  emailField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      validator: validateEmail,
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

  confirmPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Current Password'),
      validator: validatePassword,
      onSaved: (newValue) {
        _firstName = newValue;
      },
    );
  }

  phoneNumberField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Phone Number'),
      validator: validatePhoneNumber,
      onSaved: (newValue) {
        _phoneNumber = newValue;
      },
    );
  }
}
