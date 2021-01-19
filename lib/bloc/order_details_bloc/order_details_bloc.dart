import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:try_neostore/model/order_details_model.dart';
import 'package:try_neostore/repository/api_services.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  OrderDetailsBloc() : super(OrderDetailsInitial());

  @override
  Stream<OrderDetailsState> mapEventToState(
    OrderDetailsEvent event,
  ) async* {
    if (event is OnShowOrderDetails) {
      var response = await orderDetailsService(
          accessToken: event.accessToken, orderId: event.orderId);
      if (response.statusCode == 200) {
        OrderDetailsModel orderDetailsModel =
            orderDetailsModelFromJson(response.data);

        yield OrderDetailsSuccessful(orderDetailsModel: orderDetailsModel);
      } else {
        yield OrderDetailsUnsuccessful();
      }
    }
  }
}
