import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/network/api_services.dart';

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

  var _entireAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            Column(
              children: [
                TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Street Address'),
                    validator: validateFieldForValue,
                    onSaved: (newValue) {
                      _streetAddress = newValue;
                    }),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Landmark'),
                    validator: validateFieldForValue,
                    onSaved: (newValue) {
                      _landmark = newValue;
                    }),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(labelText: 'City'),
                        validator: validateFieldForValue,
                        onSaved: (newValue) {
                          _city = newValue;
                        }),
                  ),
                  Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(labelText: 'State'),
                        validator: validateFieldForValue,
                        onSaved: (newValue) {
                          _state = newValue;
                        }),
                  )
                ]),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                        maxLength: 6,
                        decoration:
                            const InputDecoration(labelText: 'Zip code'),
                        keyboardType: TextInputType.number,
                        validator: validateFieldForValue,
                        onSaved: (newValue) {
                          _zipCode = newValue;
                        }),
                  ),
                  Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(labelText: 'Country'),
                        validator: validateFieldForValue,
                        onSaved: (newValue) {
                          _country = newValue;
                        }),
                  )
                ]),
              ],
            ),
            RaisedButton(
                onPressed: () => validateInputs(), child: Text('Order Now'))
          ],
        ),
      ),
    );
  }

  validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _entireAddress = _streetAddress +
          ' ' +
          _landmark +
          ' ' +
          _city +
          ' ' +
          _state +
          ' ' +
          _zipCode +
          ' ' +
          _country;
      //
      var response = await orderItemsService(
          address: _entireAddress,
          accessToken: widget.accessToken);
      print(response.statusCode);
      if (response.statusCode == 200) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('Order Placed Successfully')));
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamedAndRemoveUntil(
            context, route_home_screen, (route) => false,
            arguments: widget.accessToken);
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     route_home_screen, (Route<dynamic> route) => false);
      }
    }
  }
}
