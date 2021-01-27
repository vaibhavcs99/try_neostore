import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../model/api_response.dart';
import '../../repository/user_repository.dart';
import '../auth_bloc/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository=UserRepository();
  
  LoginBloc({@required this.authenticationBloc})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is OnLoginButtonPressed) {
      yield LoginLoading();
      Response response =
         await userRepository.authenticateUserService(event.email, event.password);

      if (response.statusCode == 200) {
        String accessToken =
            apiResponseFromJson(response.data).data.accessToken;

        authenticationBloc.add(LoggedIn(accessToken: accessToken));
        yield LoginSuccessful(accessToken: accessToken);
      } else {
        yield LoginFailed(error: 'Invalid Credential');
      }
    }
  }
}
