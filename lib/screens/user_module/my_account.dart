import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';

import 'package:try_neostore/model/fetchDataResponse.dart';
import 'package:try_neostore/repository/api_services.dart';
import 'package:try_neostore/screens/widgets/my_drawer.dart';

class MyAccountDetails extends StatefulWidget {
  final String accessToken;

  const MyAccountDetails({Key key, this.accessToken}) : super(key: key);
  @override
  _MyAccountDetailsState createState() => _MyAccountDetailsState();
}

class _MyAccountDetailsState extends State<MyAccountDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(title: Text('My Account')),
        drawer: Drawer(
          child: MyDrawer(
            accessToken: widget.accessToken,
          ),
        ),
        body: Center(
          child: FutureBuilder<FetchDataResponse>(
              future: getDetails(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  var userData = snapshot.data.data.userData;
                  return Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${snapshot.data.data.productCategories[0].iconImage}'),
                      ),
                      Text(userData.firstName ?? 'no data'),
                      Text(userData.lastName ?? 'no data'),
                      Text(userData.email ?? 'no data'),
                      Text(userData.phoneNo ?? 'no data'),
                      Text(userData.dob ?? 'no data'),
                      FlatButton(
                          onPressed: () => Navigator.pushNamed(
                              context, route_edit_account_details,
                              arguments: widget.accessToken),
                          child: Text('Edit Profile')),
                      FlatButton(
                        onPressed: () => Navigator.pushNamed(
                            context, route_change_password,
                            arguments: widget.accessToken),
                        child: Text('Reset Password'),
                      )
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  Future<FetchDataResponse> getDetails() async {
    var response = await myAccountDetailsService(widget.accessToken);
    if (response.statusCode == 200) {
      return fetchDataResponseFromJson(response.data);
    }
    if (response.statusCode == 500) {
      print('Unsuccessful');
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you Sure?'),
          content: Text('Do you want to exit an App?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
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
