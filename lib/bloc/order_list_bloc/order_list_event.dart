part of 'order_list_bloc.dart';

abstract class OrderListEvent extends Equatable {
  const OrderListEvent();

  @override
  List<Object> get props => [];
}

class OnShowOrderList extends OrderListEvent {
  final String accessToken;
  OnShowOrderList({
    @required this.accessToken,
  });
}
