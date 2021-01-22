part of 'address_bloc.dart';

abstract class EnterAddressEvent extends Equatable {
  const EnterAddressEvent();

  @override
  List<Object> get props => [];
}

class OnSaveAddressPressed extends EnterAddressEvent {
  final String accessToken;
  final String address;
  OnSaveAddressPressed({
    @required this.accessToken,
    @required this.address,
  });
}
// class OnOrderNowPressed extends AddressEvent {
//   final String accessToken;
//   final String address;
//   OnOrderNowPressed({
//     @required this.accessToken,
//     @required this.address,
//   });
// }
