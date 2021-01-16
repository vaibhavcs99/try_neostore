// import 'package:flutter/material.dart';

// class MyRatingDialog extends StatefulWidget {
//   MyRatingDialog(
//       {@required String productName,
//       @required String productImage,
//       @required int productId});
//   @override
//   _MyRatingDialogState createState() => _MyRatingDialogState();
// }

// class _MyRatingDialogState extends State<MyRatingDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (context) {
//           return AlertDialog(
//               title: Text(productName),
//               content: SizedBox(
//                   width: 300,
//                   height: 300,
//                   child: ListView(children: [
//                     Container(
//                       child: Image.network(productImage),
//                     ),
//                     myRatingbar(),
//                     Align(
//                       child: RaisedButton(
//                         onPressed: () => setProductRatingService(
//                             productId: productId.toString(),
//                             rating: myFeedbackRating),
//                         child: Text('Rate Now'),
//                       ),
//                     )
//                   ])));
//         });
//   }
// }
