import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../model/cart_list_model.dart';
import '../../model/error.dart';
import '../../repository/cart_repository.dart';

part 'cart_list_event.dart';
part 'cart_list_state.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  final CartRepository cartRepository = CartRepository();

  CartListBloc() : super(CartListInitial());

  @override
  Stream<CartListState> mapEventToState(
    CartListEvent event,
  ) async* {
    if (event is OnShowCartList) {
      yield CartListLoading();
      var response =
          await cartRepository.cartListService(accessToken: event.accessToken);

      if (response.statusCode == 200) {
        CartListModel cartListModel = cartListModelFromJson(response.data);

        yield CartListSuccessful(cartListModel: cartListModel);
      } else {
        String error = errorModelFromJson(response.data).userMsg;

        yield CartListUnsuccessful(error: error);
      }
    }

    if (event is OnDeleteSwiped) {
      yield CartDeleteItemLoading();

      var response = await cartRepository.deleteItemCartService(
          accessToken: event.accessToken, productId: event.productId);

      if (response.statusCode == 200) {
        var response = await cartRepository.cartListService(
            accessToken: event.accessToken);
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

      var response = await cartRepository.editItemCartService(
          accessToken: event.accessToken,
          productId: event.productId,
          quantity: event.quantity);
      if (response.statusCode == 200) {
        var response = await cartRepository.cartListService(accessToken: event.accessToken);
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
