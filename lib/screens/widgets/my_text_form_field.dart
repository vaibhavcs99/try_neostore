import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final String myLabelText;
  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final Widget myIcon;
  final double rightPadding;

  MyTextFormField({
    @required this.myLabelText,
    @required this.validator,
    @required this.onSaved,
    @required this.myIcon,
    this.obscureText,
    this.keyboardType,
    this.rightPadding,
  });
// const EdgeInsets.only(left: 33,right: 33, bottom: 13),
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 9.0.w, right: rightPadding??9.0.w, bottom: 2.0.h),
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
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
