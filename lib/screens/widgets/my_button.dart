import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String myText;
  final double fontSize;
  final Color color;
  final int aspectX;
  final int aspectY;
  final Color textColor;
  MyButton({
    @required this.myText,
    @required this.onPressed,
    this.fontSize,
    this.color,
    this.aspectX,
    this.aspectY,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 10),
      child: AspectRatio(
        aspectRatio: (aspectX ?? 880) / (aspectY ?? 142),
        child: FlatButton(
          onPressed: onPressed,
          color: color ?? Colors.white,
          textColor: textColor ?? Color(0xffdb1514),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Text(
            myText,
            style: TextStyle(fontSize: fontSize ?? 25.0),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:try_neostore/constants/constants.dart';

// class WhiteButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 10),
//       child: AspectRatio(
//         aspectRatio: 880 / 142,
//         child: FlatButton(
//             color: Colors.white,
//             minWidth: double.infinity,
//             onPressed: () => Navigator.pushNamed(
//                 context, route_edit_account_details,
//                 arguments: widget.accessToken),
//             child: Text('Edit Profile')),
//       ),
//     );
//   }
// }
