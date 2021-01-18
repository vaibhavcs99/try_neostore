part of 'order_list_bloc.dart';

abstract class OrderListState extends Equatable {
  const OrderListState();

  @override
  List<Object> get props => [];
}

class OrderListInitial extends OrderListState {}

class OrderListLoading extends OrderListState {}

class OrderListSuccessful extends OrderListState {
  final OrderListModel orderListModel;
  OrderListSuccessful({
    @required this.orderListModel,
  });
}

class OrderListUnsuccessful extends OrderListState {}
