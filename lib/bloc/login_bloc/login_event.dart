part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnLoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  OnLoginButtonPressed({
    @required this.email,
    @required this.password,
  });
}
