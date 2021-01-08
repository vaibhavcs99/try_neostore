//TODO: Show snackbar on arrival.
import 'package:flutter/material.dart';
import 'package:try_neostore/model/api_response.dart';

import 'my_drawer.dart';

class HomeScreen extends StatefulWidget {
  final ApiResponse apiResponse;

  const HomeScreen({Key key, @required this.apiResponse}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(),
        drawer: Drawer(
          child: MyDrawer(widget.apiResponse),
        ),
        body: Center(
          child: Column(
            children: [
              Text("${widget.apiResponse.userMsg}"),
              Text("${widget.apiResponse.data.accessToken}"),
              Text("${widget.apiResponse.data.email}"),
              Text("${widget.apiResponse.data.username}"),
              Text("${widget.apiResponse.data.dob}"),
              Text("${widget.apiResponse.data.modified}"),
            ],
          ),
        ),
      ),
    );
  }

  showSnackBar(String title) {
    print(_scaffoldKey);
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
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
