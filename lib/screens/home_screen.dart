//TODO: Show snackbar on arrival.
import 'package:flutter/material.dart';
import 'package:try_neostore/model/api_response.dart';

class HomeScreen extends StatefulWidget {
  final  ApiResponse apiResponse;

  const HomeScreen({Key key, @required this.apiResponse}) : super(key: key);
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
    );
  }

  showSnackBar(String title) {
    print(_scaffoldKey);
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(title)));
  }
}
