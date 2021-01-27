import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Utils/validators.dart';
import '../../bloc/address_bloc/address_bloc.dart';
import '../widgets/my_button.dart';

class EnterAddress extends StatefulWidget {
  final String accessToken;

  const EnterAddress({Key key, this.accessToken}) : super(key: key);
  @override
  _EnterAddressState createState() => _EnterAddressState();
}

class _EnterAddressState extends State<EnterAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _streetAddress;
  String _landmark;
  String _city;
  String _state;
  String _country;
  String _zipCode;

  String _entireAddress;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EnterAddressBloc, EnterAddressState>(
      listener: (context, state) async {
        if (state is SaveAddressSuccessful) {
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text('Address Saved Successfully')));
          await Future.delayed(Duration(seconds: 3));
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Enter Address')),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                buildAddress(),
                SizedBox(height: 27),
                buildLandMark(),
                SizedBox(height: 27),
                buildCityAndState(),
                SizedBox(height: 27),
                buildZipAndCountry(),
                SizedBox(height: 27),
                MyButton(
                    onPressed: () => validateInputs(),
                    myText: 'Save Address',
                    color: Colors.red,
                    textColor: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildZipAndCountry() {
    return Row(children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ZIP CODE',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    letterSpacing: 1.2)),
            SizedBox(height: 17),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white),
              child: TextFormField(
                  // maxLength: 6,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                  validator: validateFieldForValue,
                  onSaved: (newValue) {
                    _zipCode = newValue;
                  }),
            ),
          ],
        ),
      ),
      SizedBox(width: 13),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('COUNTRY',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    letterSpacing: 1.2)),
            SizedBox(height: 17),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white),
              child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: validateFieldForValue,
                  onSaved: (newValue) {
                    _country = newValue;
                  }),
            ),
          ],
        ),
      )
    ]);
  }

  Row buildCityAndState() {
    return Row(children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CITY',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    letterSpacing: 1.2)),
            SizedBox(height: 17),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white),
              child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: validateFieldForValue,
                  onSaved: (newValue) {
                    _city = newValue;
                  }),
            )
          ],
        ),
      ),
      SizedBox(width: 13),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('STATE',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.0,
                    letterSpacing: 1.2)),
            SizedBox(height: 17),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white),
              child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: validateFieldForValue,
                  onSaved: (newValue) {
                    _state = newValue;
                  }),
            ),
          ],
        ),
      )
    ]);
  }

  Column buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ADDRESS',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0,
                letterSpacing: 1.2)),
        SizedBox(height: 17),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.black)),
                validator: validateFieldForValue,
                onSaved: (newValue) {
                  _streetAddress = newValue;
                }),
          ),
        ),
      ],
    );
  }

  Column buildLandMark() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('LANDMARK',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0,
                letterSpacing: 1.2)),
        SizedBox(height: 17),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.white),
          child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              validator: validateFieldForValue,
              onSaved: (newValue) {
                _landmark = newValue;
              }),
        )
      ],
    );
  }

  validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _entireAddress = _streetAddress +
          ', ' +
          _landmark +
          ', ' +
          _city +
          ', ' +
          _state +
          ', ' +
          _zipCode +
          ', ' +
          _country;
      //
      BlocProvider.of<EnterAddressBloc>(context).add(OnSaveAddressPressed(
          accessToken: widget.accessToken, address: _entireAddress));
    }
  }
}
