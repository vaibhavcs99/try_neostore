import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/data_class.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/api_response.dart';

class MyDrawer extends StatefulWidget {
  final ApiResponse apiResponse;

  const MyDrawer({Key key, this.apiResponse}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    var user = widget.apiResponse.data;
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            '${user.firstName}' + ' ' + '${user.lastName}',
            style: TextStyle(fontSize: 23),
          ),
          accountEmail: Text('${user.email}'),
          // currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(user.profilePic)),
        ),
        ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacementNamed(context, route_home_screen,
                  arguments: widget.apiResponse);
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
                    parameter1: 1, parameter2: widget.apiResponse))),
        ListTile(
            title: Text('Chair'),
            leading: Icon(Icons.shopping_cart),
            onTap: () => Navigator.pushNamed(context, route_product_list,
                //imdex+1 is product category id number
                arguments: ScreenParameters(
                    parameter1: 2, parameter2: widget.apiResponse))),
        ListTile(
            title: Text('Sofas'),
            leading: Icon(Icons.shopping_cart),
            onTap: () => Navigator.pushNamed(context, route_product_list,
                //imdex+1 is product category id number
                arguments: ScreenParameters(
                    parameter1: 3, parameter2: widget.apiResponse))),
        ListTile(
            title: Text('Bed'),
            leading: Icon(Icons.shopping_cart),
            onTap: () => Navigator.pushNamed(context, route_product_list,
                //imdex+1 is product category id number
                arguments: ScreenParameters(
                    parameter1: 4, parameter2: widget.apiResponse))),
        ListTile(
          title: Text('My Account'),
          leading: Icon(Icons.person),
          onTap: () => Navigator.pushReplacementNamed(context, route_my_account_details,
              arguments: widget.apiResponse),
        ),
        ListTile(title: Text('Store Locator'), leading: Icon(Icons.map)),
        ListTile(
            title: Text('My Orders'),
            leading: Icon(Icons.view_list),
            onTap: () => Navigator.pushReplacementNamed(
                context, route_order_list,
                arguments: widget.apiResponse)),
        ListTile(
          title: Text('LogOut'),
          leading: Icon(Icons.exit_to_app),
          onTap: _onLogOut,
        )
      ],
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
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    route_login, (Route<dynamic> route) => false), //TODO:
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
