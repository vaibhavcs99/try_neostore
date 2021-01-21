import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BorderContainer extends StatelessWidget {
  final String myText;

  final Icon myIcon;
  BorderContainer({@required this.myText, @required this.myIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 8.0.w),
      child: Container(
          width: 10.0.w,
          height: 8.0.h,
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(flex: 1, child: myIcon),SizedBox(width: 4.0.w),
              Expanded(
                flex: 6,
                child: Text(myText ?? 'No data',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          decoration: BoxDecoration(border: Border.all(color: Colors.white))),
    );
  }
}
