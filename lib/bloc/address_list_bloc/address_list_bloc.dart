import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/repository/db_helper.dart';
import 'package:try_neostore/repository/order_repository.dart';

part 'address_list_event.dart';
part 'address_list_state.dart';

class AddressListBloc extends Bloc<AddressListEvent, AddressListState> {
  final OrderRepository orderRepository = OrderRepository();
  final dbHelper = DatabaseHelper.instance;

  AddressListBloc() : super(AddressListInitial());

  @override
  Stream<AddressListState> mapEventToState(
    AddressListEvent event,
  ) async* {
    if (event is OnShowAddressList) {
      yield ShowAddressListLoading();

      List<Map<String, dynamic>> addressList = await dbHelper.queryAllRows();

      yield ShowAddressSuccessful(addressList: addressList);
    }

    if (event is OnPlaceOrderPressed) {
      yield PlaceOrderLoading();

      var response = await orderRepository.orderItemsService(
          address: event.address, accessToken: event.accessToken);

      if (response.statusCode == 200) {
        yield PlaceOrderSuccessful(accessToken: event.accessToken);
      } else {
        yield PlaceOrderUnsuccessful();
      }
    }

    if (event is OnDeleteAddressPressed) {
      yield DeleteAddressLoading();

      await dbHelper.deleteAddress(event.id);
      List<Map<String, dynamic>> addressList = await dbHelper.queryAllRows();

      yield DeleteAddressSuccessful(addressList: addressList);
    }
  }
}
