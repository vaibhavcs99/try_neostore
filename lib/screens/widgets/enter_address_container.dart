import 'package:flutter/material.dart';

class EnterAddressContainer extends StatelessWidget {
  final FormFieldValidator<String> validator;

  const EnterAddressContainer({Key key, this.validator}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ADDRESS',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.0,
                letterSpacing: 1.2)),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelStyle: TextStyle(color: Colors.black)),
                validator: validator,
                onSaved: (newValue) {
                  _streetAddress = newValue;
                }),
          ),
        ),
      ],
    );
  }
}
