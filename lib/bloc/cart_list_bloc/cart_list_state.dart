part of 'cart_list_bloc.dart';

abstract class CartListState extends Equatable {
  const CartListState();

  @override
  List<Object> get props => [];
}

class CartListInitial extends CartListState {}

class CartListLoading extends CartListState {}

class CartListSuccessful extends CartListState {
  final CartListModel cartListModel;
  CartListSuccessful({
    @required this.cartListModel,
  });
}

class CartListUnsuccessful extends CartListState {
  final String error;
  CartListUnsuccessful({
    @required this.error,
  });
}

class CartListEmpty extends CartListState {}

//*************************************************** */

class CartDeleteItemLoading extends CartListState {}

class CartDeleteItemSuccessful extends CartListState {
  final CartListModel cartListModel;
  CartDeleteItemSuccessful({
    @required this.cartListModel,
  });
}

class CartDeleteItemUnsuccessful extends CartListState {}

//**************************************************** */

class CartEditLoading extends CartListState {}

class CartEditSuccessful extends CartListState {
  final CartListModel cartListModel;
  CartEditSuccessful({
    @required this.cartListModel,
  });
}

class CartEditUnsuccessful extends CartListState {}

//************************************************ */

// class OrderNowLoading extends CartListState{}
// class OrderNowSuccessful extends CartListState{}
// class OrderNowUnuccessful extends CartListState{}