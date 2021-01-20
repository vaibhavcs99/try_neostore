import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/Utils/data_class.dart';
import 'package:try_neostore/bloc/drawer_bloc/drawer_bloc.dart';
import 'package:try_neostore/constants/constants.dart';

class MyDrawer extends StatefulWidget {
  final String accessToken;

  const MyDrawer({Key key, this.accessToken}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DrawerBloc>(context)
        .add(OnShowDrawerHeader(accessToken: widget.accessToken));

    return BlocListener<DrawerBloc, DrawerState>(
        listener: (context, state) {
          if (state is LogOutSuccessful) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                route_login, (Route<dynamic> route) => false);
          }
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: [
              buildUserAccountHeader(),
              ListTile(
                  title: Text('Home'),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, route_home_screen,
                        arguments: widget.accessToken);
                  }),
              ListTile(
                  title: Text('My Cart'),
                  leading: Icon(Icons.shopping_cart),
                  onTap: () {}),
              ListTile(
                  title: Text('Tables'),
                  leading: Icon(Icons.shopping_cart),
                  onTap: () => Navigator.pushNamed(context, route_product_list,
                      //imdex+1 is product category id number
                      arguments: ScreenParameters(
                          parameter1: 1, parameter2: widget.accessToken))),
              ListTile(
                  title: Text('Chair'),
                  leading: Icon(Icons.shopping_cart),
                  onTap: () => Navigator.pushNamed(context, route_product_list,
                      //imdex+1 is product category id number
                      arguments: ScreenParameters(
                          parameter1: 2, parameter2: widget.accessToken))),
              ListTile(
                  title: Text('Sofas'),
                  leading: Icon(Icons.shopping_cart),
                  onTap: () => Navigator.pushNamed(context, route_product_list,
                      //imdex+1 is product category id number
                      arguments: ScreenParameters(
                          parameter1: 3, parameter2: widget.accessToken))),
              ListTile(
                  title: Text('Bed'),
                  leading: Icon(Icons.shopping_cart),
                  onTap: () => Navigator.pushNamed(context, route_product_list,
                      //imdex+1 is product category id number
                      arguments: ScreenParameters(
                          parameter1: 4, parameter2: widget.accessToken))),
              ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person),
                onTap: () => Navigator.pushReplacementNamed(
                    context, route_my_account_details,
                    arguments: widget.accessToken),
              ),
              ListTile(title: Text('Store Locator'), leading: Icon(Icons.map)),
              ListTile(
                  title: Text('My Orders'),
                  leading: Icon(Icons.view_list),
                  onTap: () => Navigator.pushReplacementNamed(
                      context, route_order_list,
                      arguments: widget.accessToken)),
              ListTile(
                title: Text('LogOut'),
                leading: Icon(Icons.exit_to_app),
                onTap: _onLogOut,
              )
            ],
          ),
        ));
  }

  buildUserAccountHeader() {
    return BlocBuilder<DrawerBloc, DrawerState>(
      builder: (context, state) {
        if (state is DrawerSuccessful) {
          var user = state.fetchDataResponse.data.userData;
          return UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    user.profilePic.isEmpty? 'https://picsum.photos/200/300':user.profilePic)),
            accountName: Text(
              '${user.firstName}' + ' ' + '${user.lastName}',
              style: TextStyle(fontSize: 23),
            ),
            accountEmail: Text('${user.email}'),
          );
        }

        return UserAccountsDrawerHeader(
          accountName: Text(
            '',
            style: TextStyle(fontSize: 23),
          ),
          accountEmail: Text(''),
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
