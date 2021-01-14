import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/bloc/authBloc/authentication_bloc.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/repository/api_services.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationBloc authenticationBloc;

  RegisterBloc({@required this.authenticationBloc}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is OnRegisterButtonPressed) {
      yield RegisterLoading();

      Map<String, dynamic> userDetails = {
        'first_name': event.firstName,
        'last_name': event.lastName,
        'email': event.email,
        'password': event.password,
        'confirm_password': event.confirmPassword,
        'gender': event.gender,
        'phone_no': event.phoneNumber,
      };

      Response response = await registerUserService(userDetails: userDetails);

      if (response.statusCode == 200) {
        String accessToken =
            apiResponseFromJson(response.data).data.accessToken;

        authenticationBloc.add(LoggedIn(accessToken: accessToken));

        yield RegisterSuccessful(accessToken: accessToken);
      } else if (response.statusCode == 404) {
        yield RegisterFailed(error: 'Email Already Exists');
      }
    }
  }
}
