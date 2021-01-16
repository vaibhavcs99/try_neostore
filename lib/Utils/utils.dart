import 'package:flutter/material.dart';

String getProductCategoryName(int id) {
  List productNames = ['Tables', 'Chairs', 'Sofa', 'Bed', 'Dining set'];

  switch (id) {
    case 1:
      return productNames[id - 1];
    case 2:
      return productNames[id - 1];
    case 3:
      return productNames[id - 1];
    case 4:
      return productNames[id - 1];
    case 5:
      return productNames[id - 1];
    default:
      return 'Unknown Category';
  }
}

getRatingBar(int rating) {
  return Row(children: [
    for (var i = 0; i < rating; i++) Image.asset('assets/star_check.png'),
    for (var i = 0; i < 5-rating; i++) Image.asset('assets/star_unchek.png'),
  ]);
}
