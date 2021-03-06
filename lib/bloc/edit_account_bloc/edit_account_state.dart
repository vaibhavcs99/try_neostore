part of 'edit_account_bloc.dart';

abstract class EditAccountState extends Equatable {
  const EditAccountState();
  
  @override
  List<Object> get props => [];
}

class EditAccountInitial extends EditAccountState {}
class EditAccountLoading extends EditAccountState {}
class EditAccountSuccessful extends EditAccountState {}
class EditAccountUnsuccessful extends EditAccountState {}
