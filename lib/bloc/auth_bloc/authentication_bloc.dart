import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../repository/user_session.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserSession userSession;
  AuthenticationBloc({@required this.userSession})
      : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userSession.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield AuthenticationLoading();

      await userSession.persistToken(accessToken: event.accessToken);

      yield AuthenticationAuthenticated();
    }
    if (event is LoggedOut) {
      yield AuthenticationLoading();

      await userSession.removeToken();

      yield AuthenticationUnauthenticated();
    }
  }
}
