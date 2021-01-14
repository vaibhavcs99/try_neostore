import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/network/api_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is OnLoginButtonPressed) {
      yield LoginLoading();

      Map<String, dynamic> _userDetails = {
        'email': event.email,
        'password': event.password
      };

      Response response = await authenticateUserService(_userDetails);
      if (response.statusCode == 200) {
        String accessToken = apiResponseFromJson(response.data).data.accessToken;
        print('Login bloc successful!');
        yield LoginSuccessful(accessToken: accessToken);
      } else {
        print(response.toString());
        yield LoginFailed(error: 'Invalid redential');
      }
    }
  }
}
