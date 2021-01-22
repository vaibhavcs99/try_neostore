part of 'address_list_bloc.dart';

abstract class AddressListState extends Equatable {
  const AddressListState();

  @override
  List<Object> get props => [];
}

class AddressListInitial extends AddressListState {}

class PlaceOrderLoading extends AddressListState {}

class PlaceOrderSuccessful extends AddressListState {
  final String accessToken;
  PlaceOrderSuccessful({
    @required this.accessToken,
  });
}

class PlaceOrderUnsuccessful extends AddressListState {}

//***************************************************************************** */

class DeleteAddressLoading extends AddressListState {}

class DeleteAddressSuccessful extends AddressListState {
  final List<Map<String, dynamic>> addressList;
  DeleteAddressSuccessful({
    @required this.addressList,
  });

    @override
  List<Object> get props => [addressList];
}

class DeleteAddressUnsuccessful extends AddressListState {}

//***************************************************************************** */

class ShowAddressListLoading extends AddressListState {}

class ShowAddressSuccessful extends AddressListState {
  final List<Map<String, dynamic>> addressList;
  ShowAddressSuccessful({
    @required this.addressList,
  });

    @override
  List<Object> get props => [addressList];
}

class ShowAddressUnsuccessful extends AddressListState {}
