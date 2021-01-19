part of 'my_account_bloc.dart';

abstract class MyAccountEvent extends Equatable {
  const MyAccountEvent();

  @override
  List<Object> get props => [];
}
class OnShowAccountDetails extends MyAccountEvent {
  final String accessToken; 
  OnShowAccountDetails({
   @required this.accessToken,
  });

}

