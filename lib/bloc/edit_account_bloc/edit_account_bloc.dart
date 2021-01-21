import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:try_neostore/bloc/drawer_bloc/drawer_bloc.dart';
import 'package:try_neostore/bloc/my_account_bloc/my_account_bloc.dart';
import 'package:try_neostore/repository/user_repository.dart';

part 'edit_account_event.dart';
part 'edit_account_state.dart';

class EditAccountBloc extends Bloc<EditAccountEvent, EditAccountState> {
  final UserRepository userRepository = UserRepository();
  final MyAccountBloc myAccountBloc;
  final DrawerBloc drawerBloc;

  EditAccountBloc({
    @required this.myAccountBloc,
    @required this.drawerBloc,
  }) : super(EditAccountInitial());

  @override
  Stream<EditAccountState> mapEventToState(
    EditAccountEvent event,
  ) async* {
    if (event is OnUpdateDetailsPressed) {
      yield EditAccountLoading();
      var response = await userRepository.editAccountDetailsService(
          accessToken: event.accessToken, userDetails: event.userDetails);

      if (response.statusCode == 200) {
        myAccountBloc.add(OnShowAccountDetails(accessToken: event.accessToken));
        drawerBloc.add(OnShowDrawerHeader(accessToken: event.accessToken));
        yield EditAccountSuccessful();
      } else {
        yield EditAccountUnsuccessful();
      }
    }
  }
}
