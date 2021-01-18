part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class OnListTileClicked extends ProductListEvent {}

class ShowProductList extends ProductListEvent {
  final String productCategoryId;

  ShowProductList({@required this.productCategoryId});
}
