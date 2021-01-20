import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/model/order_details_model.dart';
import 'package:try_neostore/repository/order_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {

    final OrderRepository orderRepository = OrderRepository();

  AddressBloc() : super(AddressInitial());

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    if (event is OnOrderNowPressed) {
      yield OrderLoading();

      var response = await orderRepository. orderItemsService(
          address: event.address, accessToken: event.accessToken);

      if (response.statusCode == 200) {
        yield OrderSuccessful(accessToken: event.accessToken);
      } else {
        yield OrderUnsuccessful();
      }
    }
  }
}
