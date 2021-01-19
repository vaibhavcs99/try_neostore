part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class OnChangePasswordPressed extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  final String accessToken;
  OnChangePasswordPressed({
    @required this.currentPassword,
    @required this.newPassword,
    @required this.confirmNewPassword,
    @required this.accessToken,
  });
}
