part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessful extends LoginState {
  final String  accessToken;

  LoginSuccessful({@required this.accessToken});
}

class LoginFailed extends LoginState {
  final error;

  LoginFailed({@required this.error});
}
