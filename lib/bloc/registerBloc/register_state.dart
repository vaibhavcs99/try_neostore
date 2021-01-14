part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccessful extends RegisterState {
  final String accessToken;

  RegisterSuccessful({@required this.accessToken});
}

class RegisterFailed extends RegisterState {
  final error;

  RegisterFailed({@required this.error});
}
