part of 'order_details_bloc.dart';

abstract class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();

  @override
  List<Object> get props => [];
}

class OnShowOrderDetails extends OrderDetailsEvent {
  final String accessToken;
  final int orderId;
  OnShowOrderDetails({
   @required this.accessToken,
   @required this.orderId,
  });
}
