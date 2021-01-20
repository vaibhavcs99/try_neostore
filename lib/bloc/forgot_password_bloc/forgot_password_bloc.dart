import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/bloc/login_bloc/login_bloc.dart';
import 'package:try_neostore/model/error.dart';
import 'package:try_neostore/repository/user_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UserRepository userRepository = UserRepository();

  ForgotPasswordBloc() : super(ForgotPasswordInitial());

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is OnResetButtonPresssed) {
      yield ForgotPasswordLoading();
      var emailMap = {'email': '${event.email}'};

      var response =
          await userRepository.sendPasswordResetMailService(emailMap);

      if (response.statusCode == 200) {
        yield ForgotPasswordSuccessful();
      }
      final errorModel = errorModelFromJson(response.data);

      if (errorModel.status == 401) {
        yield ForgotPasswordUnsuccessful(error: 'Email address is incorrect');
      }
    }
  }
}
