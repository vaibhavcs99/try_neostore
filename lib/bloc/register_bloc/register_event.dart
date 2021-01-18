part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class OnRegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String confirmPassword;
  final int phoneNumber;
  final String gender;
  
  OnRegisterButtonPressed({
    @required this.email,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
    @required this.confirmPassword,
    @required this.phoneNumber,
    @required this.gender,
  });
}
