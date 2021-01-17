part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccessful extends ForgotPasswordState {}

class ForgotPasswordUnsuccessful extends ForgotPasswordState {
  final String error;

  ForgotPasswordUnsuccessful({@required this.error});
}
