import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:try_neostore/Utils/data_class.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/fetchDataResponse.dart';
import 'package:try_neostore/repository/api_services.dart';

class MyDrawer extends StatefulWidget {
  final String accessToken;

  const MyDrawer({Key key, this.accessToken}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    //***************************** */
    // myAccountDetailsService(widget.accessToken);
    //***************************** */

    return ListView(
      children: [
        FutureBuilder<FetchDataResponse>(
            future: getMyData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              var user = snapshot.data.data.userData;

              return UserAccountsDrawerHeader(
                accountName: Text(
                  '${user.firstName}' + ' ' + '${user.lastName}',
                  style: TextStyle(fontSize: 23),
                ),
                accountEmail: Text('${user.email}'),
                // currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(user.profilePic)),
              );
            }),
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
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('token');

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      route_login, (Route<dynamic> route) => false);
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

  Future<FetchDataResponse> getMyData() async {
    var myJson = await myAccountDetailsService(widget.accessToken);
    return fetchDataResponseFromJson(myJson.data);
  }
}
