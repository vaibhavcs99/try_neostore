import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/repository/api_services.dart';
import 'package:try_neostore/screens/widgets/my_text_form_field.dart';
import 'package:try_neostore/screens/widgets/my_button.dart';
import 'package:try_neostore/utils/validators.dart' as validators;

class EditAccountDetails extends StatefulWidget {
  final String accessToken;
  EditAccountDetails({@required this.accessToken});

  @override
  _EditAccountDetailsState createState() => _EditAccountDetailsState();
}

class _EditAccountDetailsState extends State<EditAccountDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _firstName;
  String _lastName;
  String _email;
  int _phoneNumber;

  String _dob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: primaryRed2,
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Edit Account Details')),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              firstNameField(), lastNameField(),
              dateOfBirth(),
              emailField(),
              phoneNumberField(),
              // MyTextFormField(
              //   myLabelText: 'First Name',
              //   validator: validateName,
              //   onSaved: (newValue) {
              //     _firstName = newValue.trim();
              //   },
              // ),
              // MyTextFormField(myLabelText: 'Last Name'),
              MyButton(
                  myText: 'Edit Account Details',
                  onPressed: () => _validateInputs())
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
    Map<String, dynamic> _userDetails = {
      'first_name': '$_firstName',
      'last_name': '$_lastName',
      'email': '$_email',
      'dob': '$_dob',
      'profile_pic': 'null',
      'phone_no': '$_phoneNumber',
    };
    var response =
        await editAccountDetailsService(widget.accessToken, _userDetails);

    if (response.statusCode == 200) {
      showSnackBar('Details updated successfully');
    }
  }

  firstNameField() {
    return MyTextFormField(myIcon: Icon(Icons.person),
      myLabelText: 'First Name',
      validator: validateName,
      onSaved: (newValue) {
        _firstName = newValue.trim();
      },
    );
  }

  lastNameField() {
    return MyTextFormField(myIcon: Icon(Icons.person),
      myLabelText: 'Last Name',
      validator: validateName,
      onSaved: (newValue) {
        _lastName = newValue.trim();
      },
    );
  }

  emailField() {
    return MyTextFormField(myIcon: Icon(Icons.mail),
      myLabelText: 'Email',
      validator: validateEmail,
      onSaved: (newValue) {
        _email = newValue.trim();
      },
    );
  }

  phoneNumberField() {
    return MyTextFormField(myIcon: Icon(Icons.phone),
      myLabelText: 'Phone Number',
      validator: validatePhoneNumber,
      onSaved: (newValue) {
        _phoneNumber = int.parse(newValue.trim());
      },
    );
  }

  dateOfBirth() {
    return MyTextFormField(myIcon: Icon(Icons.cake),
      myLabelText:
          'Date of Birth in dd-mm-yyyy',
      validator: validateDob,
      onSaved: (newValue) {
        _dob = newValue.trim();
      },
    );
  }

  //-------------------------------------------------------------------------------------------------------------
  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
