//TODO: Show snackbar on arrival.
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final accessToken;

  const HomeScreen({Key key, @required this.accessToken}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Center(
        child: Text("${widget.accessToken}"),
      ),
    );
  }

  showSnackBar(String title) {
    print(_scaffoldKey);
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
