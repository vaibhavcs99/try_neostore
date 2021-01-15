import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';

class MyWhiteButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String myText;
  final int myFontSize;
  MyWhiteButton({
    @required this.myText,
    @required this.onPressed, this.myFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 10),
      child: AspectRatio(
        aspectRatio: 880 / 142,
        child: FlatButton(
          onPressed: onPressed,
          color: Colors.white,
          textColor: Color(0xffdb1514),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Text(
            myText,
            style: TextStyle(fontSize: myFontSize??25),
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
