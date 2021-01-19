part of 'drawer_bloc.dart';

abstract class DrawerState extends Equatable {
  const DrawerState();

  @override
  List<Object> get props => [];
}

class DrawerInitial extends DrawerState {}

class DrawerLoading extends DrawerState {}

class DrawerSuccessful extends DrawerState {
  final FetchDataResponse fetchDataResponse;
  DrawerSuccessful({
   @required this.fetchDataResponse,
  });
}

class DrawerUnsuccessful extends DrawerState {}

class LogOutLoading extends DrawerState {}
class LogOutSuccessful extends DrawerState {}
class LogOutUnsuccessful extends DrawerState {}
