import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final String myLabelText;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final Widget myIcon;

  MyTextFormField(
      {@required this.myLabelText,
      @required this.validator,
      @required this.onSaved,
      @required this.myIcon,
      this.obscureText,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 33,right: 33, bottom: 13),
      child: TextFormField(
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            errorStyle: TextStyle(color: Colors.white),
            prefixIcon: myIcon,
            labelText: myLabelText,
            labelStyle:
                TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
              
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,style: TextStyle(color: Colors.white),
      ),
    );
  }
}
