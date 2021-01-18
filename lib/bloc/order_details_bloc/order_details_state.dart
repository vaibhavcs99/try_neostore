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
   @required this.orderDetailsModel,
  });
}

class OrderDetailsUnsuccessful extends OrderDetailsState {}
