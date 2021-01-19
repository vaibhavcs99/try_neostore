part of 'edit_account_bloc.dart';

abstract class EditAccountEvent extends Equatable {
  const EditAccountEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateDetailsPressed extends EditAccountEvent {
  final String accessToken;
  final Map<String, dynamic> userDetails;
  OnUpdateDetailsPressed({
    @required this.accessToken,
    @required this.userDetails,
  });
}
