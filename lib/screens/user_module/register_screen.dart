import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/bloc/register_bloc/register_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/screens/widgets/my_button.dart';
import 'package:try_neostore/screens/widgets/my_text_form_field.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _maleCheckBox = true;
  var _femaleCheckBox = false;

  String _firstName;
  String _lastName;
  String _email;
  String _password;
  String _confirmPassword;
  int _phoneNumber;
  String _gender = 'M';

  var termsAndConditionValue = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessful) {
          Navigator.pushNamed(context, route_home_screen,
              arguments: state.accessToken);
        }
        if (state is RegisterFailed) {
          print(state.error);
          showSnackBar(state.error);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: primaryRed2,
        appBar: AppBar(title: Text('Register')),
        body: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              children: [
                SizedBox(height: 3.0.h),
                Center(
                  child: Text('NeoSTORE',
                      style: TextStyle(
                          fontSize: 37.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                firstNameField(),
                lastNameField(),
                emailField(),
                passwordField(),
                confirmPasswordField(),
                buildGender(),
                phoneNumberField(),
                termsAndConditions(),
                MyButton(
                  onPressed: () {
                    (termsAndConditionValue == true)
                        ? _validateInputs()
                        : showSnackBar('Please agree to Terms & Conditions');
                  },
                  myText: 'Register',
                ),
              ],
            ),
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
    BlocProvider.of<RegisterBloc>(context).add(OnRegisterButtonPressed(
        email: _email,
        password: _password,
        firstName: _firstName,
        lastName: _lastName,
        confirmPassword: _confirmPassword,
        phoneNumber: _phoneNumber,
        gender: _gender));
  }
  //--------------------------------------------------------------------------------------------------------------
  //this part contains all the defined UI widget fields.

  firstNameField() {
    return MyTextFormField(
      myIcon: Icon(Icons.person, color: Colors.white),
      myLabelText: 'First Name',
      validator: validateName,
      onSaved: (newValue) {
        _firstName = newValue.trim();
      },
    );
  }

  lastNameField() {
    return MyTextFormField(
      myIcon: Icon(Icons.person, color: Colors.white),
      myLabelText: 'Last Name',
      validator: validateName,
      onSaved: (newValue) {
        _lastName = newValue.trim();
      },
    );
  }

  emailField() {
    return MyTextFormField(
      myIcon: Icon(Icons.mail, color: Colors.white),
      myLabelText: 'Email',
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (newValue) {
        _email = newValue.trim();
      },
    );
  }

  passwordField() {
    return MyTextFormField(
      myIcon: Icon(Icons.lock, color: Colors.white),
      myLabelText: 'Password',
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: validatePassword,
      onSaved: (newValue) {
        _password = newValue.trim();
      },
    );
  }

  confirmPasswordField() {
    return MyTextFormField(
      myIcon: Icon(Icons.lock, color: Colors.white),
      myLabelText: 'Confirm Password',
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      validator: validatePassword,
      onSaved: (newValue) {
        _confirmPassword = newValue.trim();
      },
    );
  }

  phoneNumberField() {
    return MyTextFormField(
      myIcon: Icon(Icons.phone_android, color: Colors.white),
      myLabelText: 'Phone Number',
      keyboardType: TextInputType.number,
      validator: validatePhoneNumber,
      onSaved: (newValue) {
        _phoneNumber = int.parse(newValue.trim());
      },
    );
  }

  Row buildGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Gender',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500)),
        SizedBox(width: 28.0),
        Checkbox(
          checkColor: primaryRed2,
          activeColor: Colors.white,
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
        Text('Male'),
        Checkbox(
          checkColor: primaryRed2,
          activeColor: Colors.white,
          value: _femaleCheckBox,
          onChanged: (value) {
            setState(() {
              _gender = 'F';
              _femaleCheckBox = value;
              _maleCheckBox = !value;
            });
          },
        ),
        Text('Female'),
      ],
    );
  }

  //-------------------------------------------------------------------------------------------------------------
  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }

  termsAndConditions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
            checkColor: primaryRed2,
            activeColor: Colors.white,
            value: termsAndConditionValue ?? false,
            onChanged: (value) {
              setState(() {
                termsAndConditionValue = !termsAndConditionValue;
              });
            }),
        Text('I agreee the Terms & Conditions',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
                color: Colors.white)),
      ],
    );
  }
}
