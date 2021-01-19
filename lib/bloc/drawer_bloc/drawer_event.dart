part of 'drawer_bloc.dart';

abstract class DrawerEvent extends Equatable {
  const DrawerEvent();

  @override
  List<Object> get props => [];
}

class OnShowDrawerHeader extends DrawerEvent {
  final String accessToken;
  OnShowDrawerHeader({
   @required this.accessToken,
  });
}
class OnLogOutPressed extends DrawerEvent{
  
}
