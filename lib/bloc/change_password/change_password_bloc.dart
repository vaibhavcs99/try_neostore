import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/repository/api_services.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial());

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is OnChangePasswordPressed) {
      var response = await changePasswordService(
          accessToken: event.accessToken,
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
          confirmNewPassword: event.confirmNewPassword);

      if (response.statusCode == 200) {
        yield ChangePasswordSuccessful();
      }else{
        yield ChangePasswordUnsuccessful();
      }
    }
  }
}
