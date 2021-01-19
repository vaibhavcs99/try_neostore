part of 'my_account_bloc.dart';

abstract class MyAccountState extends Equatable {
  const MyAccountState();

  @override
  List<Object> get props => [];
}

class MyAccountInitial extends MyAccountState {}

class MyAccountLoading extends MyAccountState {}

class MyAccountSuccessful extends MyAccountState {
  final FetchDataResponse fetchDataResponse;
  MyAccountSuccessful({
   @required this.fetchDataResponse,
  });
}

class MyAccountUnsuccessful extends MyAccountState {}
