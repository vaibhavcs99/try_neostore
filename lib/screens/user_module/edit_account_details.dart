import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/network/api_services.dart';

class EditAccountDetails extends StatefulWidget {
  final ApiResponse _apiResponse;
  EditAccountDetails(this._apiResponse);

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Edit Account Details')),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              firstNameField(),
              lastNameField(),
              dateOfBirth(),
              emailField(),
              phoneNumberField(),
              RaisedButton(
                onPressed: () => _validateInputs(),
                child: Text('EditAccountDetails'),
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
    Map<String, dynamic> _userDetails = {
      'first_name': '$_firstName',
      'last_name': '$_lastName',
      'email': '$_email',
      'dob': '$_dob',
      'profile_pic': 'null',
      'phone_no': '$_phoneNumber',
    };
    print(widget._apiResponse.data);
    String receivedMessage = await editAccountDetailsService(
        widget._apiResponse.data.accessToken, _userDetails);

    showSnackBar(receivedMessage);
  }
  // void registerUser() async {
  //   var dio = Dio();

  //   dio.options.headers['access_token'] = widget._apiResponse.data.accessToken;

  //   Map<String, dynamic> userDetails = {
  //     'first_name': '$_firstName',
  //     'last_name': '$_lastName',
  //     'email': '$_email',
  //     'dob': '$_dob',
  //     'profile_pic': 'null',
  //     'phone_no': '$_phoneNumber',
  //   };

  //   FormData formData = FormData.fromMap(userDetails);
  //   try {
  //     await dio
  //         .post(urlUpdateAccountDetails, data: formData)
  //         .then((value) async {
  //       showSnackBar('Account Details Updated');
  //     });
  //   } on DioError catch (dioError) {
  //     showSnackBar(dioError.response.data);
  //   } catch (e) {
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
      validator: validateEmail,
      onSaved: (newValue) {
        _email = newValue.trim();
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

  dateOfBirth() {
    return TextFormField(
      decoration:
          const InputDecoration(labelText: 'Date of Birth in dd-mm-yyyy'),
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
