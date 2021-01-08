import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/api_response.dart';

class MyDrawer extends StatefulWidget {
  final ApiResponse _apiResponse;

  const MyDrawer(
    this._apiResponse, {
    Key key,
  }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    var user = widget._apiResponse.data;
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            '${user.firstName}' + ' ' + '${user.lastName}',
            style: TextStyle(fontSize: 23),
          ),
          accountEmail: Text('${user.email}'),
          currentAccountPicture: CircleAvatar(backgroundImage: user.profilePic),
        ),
        ListTile(
          title: Text('My Cart'),
          leading: Icon(Icons.shopping_cart),
          onTap: () {},
        ),
        ListTile(title: Text('Tables'), leading: Icon(Icons.shopping_cart)),
        ListTile(title: Text('Sofas'), leading: Icon(Icons.shopping_cart)),
        ListTile(title: Text('Chairs'), leading: Icon(Icons.shopping_cart)),
        ListTile(title: Text('Cupboards'), leading: Icon(Icons.shopping_cart)),
        ListTile(
          title: Text('My Account'),
          leading: Icon(Icons.person),
          onTap: () => Navigator.pushReplacementNamed(context, route_my_account_details,arguments:  widget._apiResponse),
        ),
        ListTile(title: Text('Store Locator'), leading: Icon(Icons.map)),
        ListTile(title: Text('My Orders'), leading: Icon(Icons.view_list)),
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
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(route_login,(Route<dynamic> route) => false),//TODO:
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
