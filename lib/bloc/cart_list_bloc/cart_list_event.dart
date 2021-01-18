part of 'cart_list_bloc.dart';

abstract class CartListEvent extends Equatable {
  const CartListEvent();

  @override
  List<Object> get props => [];
}

class OnShowCartList extends CartListEvent {
  final String accessToken;
  OnShowCartList({
    @required this.accessToken,
  });
}

// class OnOrderNowPressed extends CartListEvent {
//     final String accessToken;
//   OnOrderNowPressed({
//     @required this.accessToken,
//   });
// }

class OnDeleteSwiped extends CartListEvent {
  final int productId;
  final String accessToken;
  OnDeleteSwiped({
    @required this.productId,
    @required this.accessToken,
  });
}

class OnDropDownPressed extends CartListEvent {
  final int productId;
  final int quantity;
  final String accessToken;
  OnDropDownPressed({
    @required this.productId,
    @required this.quantity,
    @required this.accessToken,
  });
}
