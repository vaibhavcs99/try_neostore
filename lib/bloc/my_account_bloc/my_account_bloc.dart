import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/model/fetchDataResponse.dart';
import 'package:try_neostore/repository/api_services.dart';

part 'my_account_event.dart';
part 'my_account_state.dart';

class MyAccountBloc extends Bloc<MyAccountEvent, MyAccountState> {
  MyAccountBloc() : super(MyAccountInitial());

  @override
  Stream<MyAccountState> mapEventToState(
    MyAccountEvent event,
  ) async* {
    if (event is OnShowAccountDetails) {
      var response = await myAccountDetailsService(event.accessToken);
      if (response.statusCode == 200) {
        var fetchDataResponse = fetchDataResponseFromJson(response.data);
        yield MyAccountSuccessful(fetchDataResponse: fetchDataResponse);
      }
      if (response.statusCode == 500) {
        yield MyAccountUnsuccessful();
      }
    }
  }
}
