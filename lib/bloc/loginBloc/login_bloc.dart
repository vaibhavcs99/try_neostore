import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/bloc/authBloc/authentication_bloc.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/network/api_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;
  LoginBloc({@required this.authenticationBloc}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is OnLoginButtonPressed) {
      yield LoginLoading();

      Response response =
          await authenticateUserService(event.email, event.password);

      if (response.statusCode == 200) {
        String accessToken =
            apiResponseFromJson(response.data).data.accessToken;
            
        print('Login bloc successful!');
        authenticationBloc.add(LoggedIn(accessToken: accessToken));
        yield LoginSuccessful(accessToken: accessToken);
      } else {
        yield LoginFailed(error: 'Invalid redential');
      }
    }
  }
}
