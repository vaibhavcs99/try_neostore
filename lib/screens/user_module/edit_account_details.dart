import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../Utils/validators.dart';
import '../../bloc/edit_account_bloc/edit_account_bloc.dart';
import '../../constants/constants.dart';
import '../widgets/container_white_border.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_form_field.dart';

class EditAccountDetails extends StatefulWidget {
  final String accessToken;
  final String profilePic;
  EditAccountDetails({
    Key key,
    @required this.accessToken,
    @required this.profilePic,
  }) : super(key: key);

  @override
  _EditAccountDetailsState createState() => _EditAccountDetailsState();
}

class _EditAccountDetailsState extends State<EditAccountDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  File _image;
  String _firstName;
  String _lastName;
  String _email;
  int _phoneNumber;

  DateTime selectedDate = DateTime.now();

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditAccountBloc, EditAccountState>(
      listener: (context, state) {
        if (state is EditAccountSuccessful) {
          showSnackBar('Details Updated Successfully!');
        }
        if (state is EditAccountUnsuccessful) {
          showSnackBar('Something went wrong!');
        }
      },
      child: Scaffold(
        backgroundColor: primaryRed2,
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Edit Account Details')),
        body: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              children: [
                SizedBox(height: 2.0.h),
                profilePic(),
                SizedBox(height: 4.0.h),
                firstNameField(),
                lastNameField(),
                emailField(),
                phoneNumberField(),
                dateOfBirth(),
                MyButton(
                    myText: 'Update Details',
                    onPressed: () => _validateInputs())
              ],
            ),
          ),
        ),
      ),
    );
  }
  //----------------------------------------------------------------------------------------------------------------

  _imageFromCamera() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 1);

    if (pickedFile == null) {
      print('Image is null!');
    } else {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    final imageBytes = _image.readAsBytesSync();
    String myImage = base64Encode(imageBytes);
    print(myImage.length);
  }

  _imageFromGallery() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile == null) {
      print('Image is null!');
    } else {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

//----------------------------------------------------------------------------------------------------------------

  Widget profilePic() {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Center(
          child: _image != null
              ? Container(
                  width: 40.0.w,
                  height: 20.0.h,
                  child: Image.file(_image, fit: BoxFit.contain),
                )
              : Container(
                  width: 40.0.w,
                  height: 20.0.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(widget.profilePic == null
                          ? 'https://picsum.photos/200/300'
                          : widget.profilePic),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
        ),
        Positioned(
            top: 15.0.h,
            right: 34.0.w,
            child: InkWell(
              onTap: () => _showPicker(context),
              child: Container(
                padding: EdgeInsets.all(1.0.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 10.0.w,
                  color: Colors.red,
                ),
              ),
            ))
      ],
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      clearAllTexts();
      registerUser(); //same method as authenticate user.
    } else {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Please Enter all Fields')));
    }
  }

  void registerUser() async {
    String finalImage;
    String initialPart = 'data:image/jpg;base64,';
    if (_image != null) {
      final imageBytes = _image.readAsBytesSync();
      finalImage = base64Encode(imageBytes);
      print(initialPart + finalImage.substring(0, 100));
    }

    Map<String, dynamic> _userDetails = {
      'first_name': _firstName,
      'last_name': _lastName,
      'email': _email,
      'dob': selectedDate,
      'profile_pic': _image == null
          ? (widget.profilePic == null ? 'null' : widget.profilePic)
          : initialPart + finalImage,
      'phone_no': _phoneNumber,
    };
    BlocProvider.of<EditAccountBloc>(context).add(OnUpdateDetailsPressed(
        accessToken: widget.accessToken, userDetails: _userDetails));
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
  }

  firstNameField() {
    return MyTextFormField(
      myIcon: Icon(Icons.person, color: Colors.white),
      myLabelText: 'First Name',
      controller: firstNameController,
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
      controller: lastNameController,
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
      controller: emailController,
      onSaved: (newValue) {
        _email = newValue.trim();
      },
    );
  }

  phoneNumberField() {
    return MyTextFormField(
      myIcon: Icon(Icons.phone, color: Colors.white),
      myLabelText: 'Phone Number',
      keyboardType: TextInputType.number,
      validator: validatePhoneNumber,
      controller: phoneNumberController,
      onSaved: (newValue) {
        _phoneNumber = int.parse(newValue.trim());
      },
    );
  }

  dateOfBirth() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Expanded(
        //   flex: 80,
        //   child: MyTextFormField(
        //     myIcon: Icon(Icons.cake, color: Colors.white),
        //     myLabelText: 'Date of Birth',
        //     validator: validateDob,
        //     keyboardType: TextInputType.datetime,
        //     rightPadding: 0,
        //     onSaved: (newValue) {
        //       _dob = newValue.trim();
        //     },
        //   ),
        // ),
        Expanded(
            flex: 70,
            child: BorderContainer(
                myText: selectedDate.day.toString() +
                    ' / ' +
                    selectedDate.month.toString() +
                    ' / ' +
                    selectedDate.year.toString(),
                myIcon: Icon(Icons.cake, color: Colors.white))),
        Expanded(
            flex: 30,
            child: InkWell(
                onTap: () => _selectDate(context),
                child: Icon(Icons.calendar_today,
                    color: Colors.white, size: 26.0.sp)))
      ],
    );
  }

  //-------------------------------------------------------------------------------------------------------------
  showSnackBar(String title) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }

  void _showPicker(BuildContext buildContext) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Container(
            child: SizedBox(
              height: 17.0.h,
              child: Column(children: [
                ListTile(
                  leading: Icon(Icons.camera_alt, color: Colors.red),
                  title: Text('Camera'),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library, color: Colors.red),
                  title: Text('Pick from gallery'),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.pop(context);
                  },
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  _selectDate(BuildContext buildContext) async {
    final DateTime receivedTime = await showDatePicker(
        context: buildContext,
        initialDate: selectedDate,
        firstDate: DateTime(1970, 1),
        lastDate: selectedDate);

    if (receivedTime != null) {
      setState(() {
        selectedDate = receivedTime;
      });
    }
  }

  void clearAllTexts() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
  }
}
