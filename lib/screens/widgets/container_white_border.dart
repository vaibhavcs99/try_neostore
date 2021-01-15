import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final String myText;
  BorderContainer({@required this.myText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 33),
      child: AspectRatio(
          aspectRatio: 22 / 3,
          child: Container(
              alignment: Alignment.center,
              child: Text(myText ?? 'no data',
                  style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600)),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)))),
    );
  }
}
