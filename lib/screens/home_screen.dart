//TODO: Show snackbar on arrival.
import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/api_response.dart';

import 'my_drawer.dart';

class HomeScreen extends StatefulWidget {
  final ApiResponse apiResponse;

  const HomeScreen(this.apiResponse, {Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List productNames = ['Tables', 'Chairs', 'Sofa', 'Bed','Dining set'];

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
        body: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                Text("${widget.apiResponse.userMsg}"),
                Text("${widget.apiResponse.data.accessToken}"),
                Text("${widget.apiResponse.data.email}"),
                Text("${widget.apiResponse.data.username}"),
                Text("${widget.apiResponse.data.dob}"),
                Text("${widget.apiResponse.data.modified}"),
              ],
            ),
            Expanded(
              child: Container(
                child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(5, (index) {
                      return Container(
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, route_product_list,
                              arguments: index + 1),
                          child: Card(
                            child: Text(productNames[index]),
                          ),
                        ),
                      );
                    })),
              ),
            )
          ],
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
