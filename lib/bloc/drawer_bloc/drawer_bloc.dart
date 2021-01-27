import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../model/fetchDataResponse.dart';
import '../../repository/user_repository.dart';
import '../auth_bloc/authentication_bloc.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository = UserRepository();

  DrawerBloc({@required this.authenticationBloc}) : super(DrawerInitial());

  @override
  Stream<DrawerState> mapEventToState(
    DrawerEvent event,
  ) async* {
    if (event is OnShowDrawerHeader) {
      var response =
          await userRepository.myAccountDetailsService(event.accessToken);

      if (response.statusCode == 200) {
        FetchDataResponse fetchDataResponse =
            fetchDataResponseFromJson(response.data);

        yield DrawerSuccessful(fetchDataResponse: fetchDataResponse);
      } else {
        yield DrawerUnsuccessful();
      }
    }

    if (event is OnLogOutPressed) {
      yield LogOutLoading();

      authenticationBloc.add(LoggedOut());

      yield LogOutSuccessful();
    }
  }
}
