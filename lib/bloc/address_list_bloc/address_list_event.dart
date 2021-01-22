part of 'address_list_bloc.dart';

abstract class AddressListEvent extends Equatable {
  const AddressListEvent();

  @override
  List<Object> get props => [];
}

class OnShowAddressList extends AddressListEvent{
  
}

class OnPlaceOrderPressed extends AddressListEvent {
  final String address;
  final String accessToken;
  OnPlaceOrderPressed({
    @required this.address,
    @required this.accessToken,
  });
}

class OnDeleteAddressPressed extends AddressListEvent {
  final int id;
  OnDeleteAddressPressed({
   @required this.id,
  });
}
