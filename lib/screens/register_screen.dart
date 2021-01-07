import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var maleCheckBox = false;
  var femaleCheckBox = false;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var gender;
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
        appBar: AppBar(),
        body: Center(
          child: ListView(
            children: [
              buildTextField('First Name',firstNameController),
              buildTextField('Last Name',lastNameController),
              buildTextField('Email',emailController),
              buildTextField('Password',passwordController),
              buildTextField('Confirm Password',confirmPasswordController),
              buildGender(),
              buildTextField('Phone Number',phoneNumberController),
              RaisedButton(
                  onPressed: () => print('Pressed'), child: Text('Login'))
            ],
          ),
        ));
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
                maleCheckBox = value;
              });
            },
          ),
        ),
        Expanded(flex: 1, child: Text('Male')),
        Expanded(
          flex: 1,
          child: Checkbox(
            value: maleCheckBox,
            onChanged: (value) {
              gender = 'Male';
              setState(() {
                maleCheckBox = value;
              });
            },
          ),
        ),
        Expanded(flex: 1, child: Text('Female')),
      ],
    );
  }

  TextField buildTextField(String title, TextEditingController _controller) {
    return TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: '$title'));
  }
}
