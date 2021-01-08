import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/utils.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/constants/urls.dart';
import 'package:try_neostore/model/api_response.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState>_scaffoldKey = GlobalKey<ScaffoldState>();

  var _maleCheckBox = true;
  var _femaleCheckBox = false;

  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _confirmPassword;
  int _phoneNumber;
  String _gender = 'M';

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
                onPressed: () => _validateInputs(),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
//----------------------------------------------------------------------------------------------------------------

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      registerUser(); //same method as authenticate user.
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Please Enter all Fields')));
    }
  }

  void registerUser() async {
    var dio = Dio();

    Map<String, dynamic> userDetails = {
      'first_name': '$_firstName',
      'last_name': '$_lastName',
      'email': '$_email',
      'password': '$_password',
      'confirm_password': '$_confirmPassword',
      'gender': '$_gender',
      'phone_no': '$_phoneNumber',
    };

    FormData formData = FormData.fromMap(userDetails);
    try {
      await dio.post(urlRegister, data: formData).then((value) {
        final apiResponse = apiResponseFromJson(value.data);
        Navigator.pushNamed(context, route_home_screen, arguments: apiResponse);
      });
    } on DioError catch (dioError) {
      print(dioError);
      showSnackBar(dioError.response.data);
    } catch (e) {
      print(e);
      showSnackBar(e.toString());
    }
  }

  //--------------------------------------------------------------------------------------------------------------
  //this part contains all the defined UI widget fields.

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

  Row buildGender() {
    return Row(
      children: [
        Expanded(flex: 3, child: Text('Gender')),
        Expanded(
          flex: 1,
          child: Checkbox(
            value: _maleCheckBox,
            onChanged: (value) {
              _gender = 'M';
              setState(() {
                _gender = 'M';
                _maleCheckBox = value;
                _femaleCheckBox = !value;
              });
            },
          ),
        ),
        Expanded(flex: 1, child: Text('Male')),
        Expanded(
          flex: 1,
          child: Checkbox(
            value: _femaleCheckBox,
            onChanged: (value) {
              setState(() {
                _gender = 'F';
                _femaleCheckBox = value;
                _maleCheckBox = !value;
              });
            },
          ),
        ),
        Expanded(flex: 1, child: Text('Female')),
      ],
    );
  }

  //-------------------------------------------------------------------------------------------------------------
  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
