import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/repository/db_helper.dart';
import 'package:try_neostore/repository/order_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class EnterAddressBloc extends Bloc<EnterAddressEvent, EnterAddressState> {
  final dbHelper = DatabaseHelper.instance;

  EnterAddressBloc() : super(EnterAddressInitial());

  @override
  Stream<EnterAddressState> mapEventToState(
    EnterAddressEvent event,
  ) async* {
    if (event is OnSaveAddressPressed) {
      yield SaveAddressLoading();

      Map<String, String> myAddress = {
        DatabaseHelper.columnAddress: event.address
      };
      await dbHelper.insertAddress(myAddress);
      
      yield SaveAddressSuccessful(accessToken: event.accessToken);
    }


  }
}
