import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/bloc/register_bloc.dart';
import 'package:try_neostore/constants/constants.dart';

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

  // void registerUser() async {
  //   var dio = Dio();

  //   Map<String, dynamic> userDetails = {
  //     'first_name': '$_firstName',
  //     'last_name': '$_lastName',
  //     'email': '$_email',
  //     'password': '$_password',
  //     'confirm_password': '$_confirmPassword',
  //     'gender': '$_gender',
  //     'phone_no': '$_phoneNumber',
  //   };

  //   FormData formData = FormData.fromMap(userDetails);
  //   try {
  //     await dio.post(urlRegister, data: formData).then((value) {
  //       final apiResponse = apiResponseFromJson(value.data);
  //       Navigator.pushNamed(context, route_home_screen, arguments: apiResponse);
  //     });
  //   } on DioError catch (dioError) {
  //     print(dioError);
  //     showSnackBar(dioError.response.data);
  //   } catch (e) {
  //     print(e);
  //     showSnackBar(e.toString());
  //   }
  // }

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
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (newValue) {
        _email = newValue.trim();
      },
    );
  }

  passwordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      keyboardType: TextInputType.visiblePassword,
      validator: validatePassword,
      onSaved: (newValue) {
        _password = newValue.trim();
      },
    );
  }

  confirmPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Confirm Password'),
      keyboardType: TextInputType.visiblePassword,
      validator: validatePassword,
      onSaved: (newValue) {
        _confirmPassword = newValue.trim();
      },
    );
  }

  phoneNumberField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Phone Number'),
      keyboardType: TextInputType.number,
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
