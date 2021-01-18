part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

//**************************************************** */
class OrderLoading extends AddressState {}

class OrderSuccessful extends AddressState {
  final String accessToken;
  OrderSuccessful({
   @required this.accessToken,
  });
}

class OrderUnsuccessful extends AddressState {}
