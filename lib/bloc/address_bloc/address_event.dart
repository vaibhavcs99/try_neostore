part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class OnOrderNowPressed extends AddressEvent {
  final String accessToken;
  final String address;
  OnOrderNowPressed({
    @required this.accessToken,
    @required this.address,
  });
}
