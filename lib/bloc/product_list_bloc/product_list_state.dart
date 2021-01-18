part of 'product_list_bloc.dart';

abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListSuccessful extends ProductListState {
  final ProductsListModel productsListModel;

  ProductListSuccessful({@required this.productsListModel});
}

class ProductListUnsuccessful extends ProductListState {
  final String error;

  ProductListUnsuccessful({@required this.error});
}
