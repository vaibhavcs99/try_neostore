import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final String myText;

  final Icon myIcon;
  BorderContainer({@required this.myText, @required this.myIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 33),
      child: AspectRatio(
          aspectRatio: 22 / 3,
          child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  SizedBox(width: 8),
                  myIcon,
                  SizedBox(width: 12),
                  Text(myText ?? 'No data',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)))),
    );
  }
}
