part of 'order_details_bloc.dart';

abstract class OrderDetailsState extends Equatable {
  const OrderDetailsState();

  @override
  List<Object> get props => [];
}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsSuccessful extends OrderDetailsState {
  final OrderDetailsModel orderDetailsModel;

  OrderDetailsSuccessful({
    this.orderDetailsModel,

  });

    @override
  List<Object> get props => [orderDetailsModel];
}

class OrderDetailsUnsuccessful extends OrderDetailsState {}
