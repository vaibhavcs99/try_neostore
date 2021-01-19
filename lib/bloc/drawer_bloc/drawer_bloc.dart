import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:try_neostore/bloc/auth_bloc/authentication_bloc.dart';
import 'package:try_neostore/model/fetchDataResponse.dart';
import 'package:try_neostore/repository/api_services.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final AuthenticationBloc authenticationBloc;

  DrawerBloc({@required this.authenticationBloc}) : super(DrawerInitial());

  @override
  Stream<DrawerState> mapEventToState(
    DrawerEvent event,
  ) async* {
    if (event is OnShowDrawerHeader) {
      var response = await myAccountDetailsService(event.accessToken);

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
