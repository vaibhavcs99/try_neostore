import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'resetpassword_event.dart';
part 'resetpassword_state.dart';

class ResetpasswordBloc extends Bloc<ResetpasswordEvent, ResetpasswordState> {
  ResetpasswordBloc() : super(ResetpasswordInitial());

  @override
  Stream<ResetpasswordState> mapEventToState(
    ResetpasswordEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
