import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Utils/data_class.dart';
import '../../bloc/cart_list_bloc/cart_list_bloc.dart';
import '../../bloc/drawer_bloc/drawer_bloc.dart';
import '../../constants/constants.dart';

class MyDrawer extends StatefulWidget {
  final String accessToken;

  const MyDrawer({Key key, @required this.accessToken}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DrawerBloc>(context)
        .add(OnShowDrawerHeader(accessToken: widget.accessToken));
    BlocProvider.of<CartListBloc>(context)
        .add(OnShowCartList(accessToken: widget.accessToken));

    return BlocListener<DrawerBloc, DrawerState>(
        listener: (context, state) {
          if (state is LogOutSuccessful) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                route_login, (Route<dynamic> route) => false);
          }
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: colorBlackBackground,
            child: ListView(
              shrinkWrap: true,
              children: [
                buildUserAccountHeader(),
                Divider(color: Colors.black, thickness: 2),
                ListTile(
                    title: Text('Home', style: TextStyle(color: Colors.white)),
                    leading: Icon(Icons.home, color: Colors.white),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, route_home_screen,
                          arguments: widget.accessToken);
                    }),
                Divider(color: Colors.black, thickness: 2),
                BlocBuilder<CartListBloc, CartListState>(
                  builder: (context, state) {
                    if (state is CartListSuccessful) {
                      int count = state.cartListModel.count;
                      return ListTile(
                          title: Text('My Cart',
                              style: TextStyle(color: Colors.white)),
                          leading:
                              Icon(Icons.shopping_cart, color: Colors.white),
                          trailing: Badge(padding: EdgeInsets.all(12),
                            badgeContent:
                                Text(count==null?'0':count.toString()),
                            child: Icon(Icons.settings),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, route_cart_list,
                                arguments: widget.accessToken);
                          });
                    }
                    return buildCartListTileGeneral(context);
                  },
                ),
                Divider(color: Colors.black, thickness: 2),
                ListTile(
                    title:
                        Text('Tables', style: TextStyle(color: Colors.white)),
                    leading:
                        Image.asset('assets/icons/tables_icon.png', scale: 0.8),
                    onTap: () => Navigator.pushNamed(
                        context, route_product_list,
                        //imdex+1 is product category id number
                        arguments: ScreenParameters(
                            parameter1: 1, parameter2: widget.accessToken))),
                Divider(color: Colors.black, thickness: 2),
                ListTile(
                    title:
                        Text('Chairs', style: TextStyle(color: Colors.white)),
                    leading:
                        Image.asset('assets/icons/chair_icon.png', scale: 0.8),
                    onTap: () => Navigator.pushNamed(
                        context, route_product_list,
                        //imdex+1 is product category id number
                        arguments: ScreenParameters(
                            parameter1: 2, parameter2: widget.accessToken))),
                Divider(color: Colors.black, thickness: 2),
                ListTile(
                    title: Text('Sofas', style: TextStyle(color: Colors.white)),
                    leading:
                        Image.asset('assets/icons/sofa_icon.png', scale: 0.8),
                    onTap: () => Navigator.pushNamed(
                        context, route_product_list,
                        //imdex+1 is product category id number
                        arguments: ScreenParameters(
                            parameter1: 3, parameter2: widget.accessToken))),
                Divider(color: Colors.black, thickness: 2),
                ListTile(
                    title: Text('Cupboards',
                        style: TextStyle(color: Colors.white)),
                    leading: Image.asset('assets/icons/cupboard_icon.png',
                        scale: 0.8),
                    onTap: () => Navigator.pushNamed(
                        context, route_product_list,
                        //imdex+1 is product category id number
                        arguments: ScreenParameters(
                            parameter1: 4, parameter2: widget.accessToken))),
                Divider(color: Colors.black, thickness: 2),
                ListTile(
                  title:
                      Text('My Account', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.person, color: Colors.white),
                  onTap: () => Navigator.pushReplacementNamed(
                      context, route_my_account_details,
                      arguments: widget.accessToken),
                ),
                Divider(color: Colors.black, thickness: 2),
                ListTile(
                    title: Text('Store Locator',
                        style: TextStyle(color: Colors.white)),
                    leading: Icon(Icons.map, color: Colors.white)),
                Divider(color: Colors.black, thickness: 2),
                ListTile(
                    title: Text('My Orders',
                        style: TextStyle(color: Colors.white)),
                    leading: Icon(Icons.view_list, color: Colors.white),
                    onTap: () => Navigator.pushReplacementNamed(
                        context, route_order_list,
                        arguments: widget.accessToken)),
                Divider(color: Colors.black, thickness: 2),
                ListTile(
                  title: Text('LogOut', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.exit_to_app, color: Colors.white),
                  onTap: _onLogOut,
                )
              ],
            ),
          ),
        ));
  }

  ListTile buildCartListTileGeneral(BuildContext context) {
    return ListTile(
                      title: Text('My Cart',
                          style: TextStyle(color: Colors.white)),
                      leading: Icon(Icons.shopping_cart, color: Colors.white),
                      trailing: Badge(
                        badgeContent:
                            Text('0'),
                        child: Icon(Icons.settings),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, route_cart_list,
                            arguments: widget.accessToken);
                      });
  }

  buildUserAccountHeader() {
    return BlocBuilder<DrawerBloc, DrawerState>(
      builder: (context, state) {
        if (state is DrawerSuccessful) {
          var user = state.fetchDataResponse.data.userData;
          return Container(
            color: colorBlackBackground,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: colorBlackBackground),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePic==null || user.profilePic==''
                      ? 'https://picsum.photos/200/300'
                      : user.profilePic)),
              accountName: Text(
                '${user.firstName}' + ' ' + '${user.lastName}',
                style: TextStyle(fontSize: 23),
              ),
              accountEmail: Text('${user.email}'),
            ),
          );
        }

        return Container(
          color: colorBlackBackground,
          child: UserAccountsDrawerHeader(
            accountName: Text(
              '',
              style: TextStyle(fontSize: 23),
            ),
            accountEmail: Text(''),
          ),
        );
      },
    );
  }

  _onLogOut() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you Sure?'),
          content: Text('Do you want to exit an App?'),
          actions: [
            TextButton(
                onPressed: () async {
                  BlocProvider.of<DrawerBloc>(context).add(OnLogOutPressed());
                },
                child: Text('Yes')),
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No')),
          ],
        );
      },
    );
  }
}
