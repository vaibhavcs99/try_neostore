import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../model/order_list_model.dart';
import '../../repository/order_repository.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {

     final OrderRepository orderRepository = OrderRepository();
     
  OrderListBloc() : super(OrderListInitial());

  @override
  Stream<OrderListState> mapEventToState(
    OrderListEvent event,
  ) async* {
    if (event is OnShowOrderList) {
      var response = await orderRepository. orderListService(accessToken: event.accessToken);
      if (response.statusCode == 200) {
        OrderListModel orderListModel = orderListModelFromJson(response.data);
        yield OrderListSuccessful(orderListModel: orderListModel);
      } else {
        yield OrderListUnsuccessful();
      }
    }
  }
}
