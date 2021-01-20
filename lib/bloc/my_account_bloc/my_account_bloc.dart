import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/model/fetchDataResponse.dart';
import 'package:try_neostore/repository/user_repository.dart';

part 'my_account_event.dart';
part 'my_account_state.dart';

class MyAccountBloc extends Bloc<MyAccountEvent, MyAccountState> {
  final UserRepository userRepository = UserRepository();

  MyAccountBloc() : super(MyAccountInitial());

  @override
  Stream<MyAccountState> mapEventToState(
    MyAccountEvent event,
  ) async* {
    if (event is OnShowAccountDetails) {
      var response =
          await userRepository.myAccountDetailsService(event.accessToken);
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
