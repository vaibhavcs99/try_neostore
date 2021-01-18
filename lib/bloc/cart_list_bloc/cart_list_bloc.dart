import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/model/cart_list_model.dart';
import 'package:try_neostore/model/error.dart';
import 'package:try_neostore/repository/api_services.dart';

part 'cart_list_event.dart';
part 'cart_list_state.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  CartListBloc() : super(CartListInitial());

  @override
  Stream<CartListState> mapEventToState(
    CartListEvent event,
  ) async* {
    if (event is OnShowCartList) {
      yield CartListLoading();
      var response = await cartListService(accessToken: event.accessToken);

      CartListModel cartListModel = cartListModelFromJson(response.data);

      if (response.statusCode == 200) {
        yield CartListSuccessful(cartListModel: cartListModel);
      } else {
        String error = errorModelFromJson(response.data).userMsg;

        yield CartListUnsuccessful(error: error);
      }
    }

    if (event is OnDeleteSwiped) {
      yield CartDeleteItemLoading();

      var response = await deleteItemCartService(
          accessToken: event.accessToken, productId: event.productId);

      if (response.statusCode == 200) {
        var response = await cartListService(accessToken: event.accessToken);
        if (response.statusCode == 200) {
          CartListModel cartListModel = cartListModelFromJson(response.data);
          yield CartDeleteItemSuccessful(cartListModel: cartListModel);
        }
      } else {
        yield CartDeleteItemUnsuccessful();
      }
    }

    if (event is OnDropDownPressed) {
      yield CartEditLoading();

      var response = await editItemCartService(
          accessToken: event.accessToken,
          productId: event.productId,
          quantity: event.quantity);
      if (response.statusCode == 200) {
        var response = await cartListService(accessToken: event.accessToken);
        if (response.statusCode == 200) {
          CartListModel cartListModel = cartListModelFromJson(response.data);
          yield CartEditSuccessful(cartListModel: cartListModel);
        } else {
          yield CartEditUnsuccessful();
        }
      }
    }
  }
}
