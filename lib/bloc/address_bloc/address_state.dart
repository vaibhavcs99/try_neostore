part of 'address_bloc.dart';

abstract class EnterAddressState extends Equatable {
  const EnterAddressState();

  @override
  List<Object> get props => [];
}

class EnterAddressInitial extends EnterAddressState {}

//**************************************************** */
class SaveAddressLoading extends EnterAddressState {}

class SaveAddressSuccessful extends EnterAddressState {
  final String accessToken;
  SaveAddressSuccessful({
   @required this.accessToken,
  });
}

class SaveAddressUnsuccessful extends EnterAddressState {}
