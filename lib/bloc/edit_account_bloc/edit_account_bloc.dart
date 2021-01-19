import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/repository/api_services.dart';

part 'edit_account_event.dart';
part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  EditAccountBloc() : super(EditAccountInitial());

  @override
  Stream<EditAccountState> mapEventToState(
    EditAccountEvent event,
  ) async* {
    if (event is OnUpdateDetailsPressed) {
      yield EditAccountLoading();
      var response = await editAccountDetailsService(
          accessToken: event.accessToken, userDetails: event.userDetails);

      if (response.statusCode == 200) {
        yield EditAccountSuccessful();
      } else {
        yield EditAccountUnsuccessful();
      }
    }
  }
}
