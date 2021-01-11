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
