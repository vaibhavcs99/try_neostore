// import 'package:flutter/material.dart';

// class MyDropDown extends StatefulWidget {
//   @override
//   _MyDropDownState createState() => _MyDropDownState();
// }

// class _MyDropDownState extends State<MyDropDown> {
//   List itemList = <int>[1, 2, 3, 4, 5, 6, 7, 8];
//   int dropDownValue = 1;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<int>(
//       value: dropDownValue,
//       items: itemList
//           .map((e) => DropdownMenuItem<int>(value: e, child: Text('$e')))
//           .toList(),
//       onChanged: (value) {
//         setState(() {
//           dropDownValue = value;
//         });
//       },
//     );
//   }
// }
