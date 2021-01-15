//TODO: Show snackbar on arrival.
import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/data_class.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/screens/widgets/my_drawer.dart';

import 'widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  final String accessToken;

  const HomeScreen({Key key, this.accessToken}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List productNames = ['Tables', 'Chairs', 'Sofa', 'Bed', 'Dining set'];
  List<String> productImages = [
    "assets/tableicon.png",
    "assets/chairsicon.png",
    "assets/sofaicon.png",
    "assets/cupboardicon.png",
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: InkWell(
                  onTap: () => Navigator.pushNamed(context, route_cart_list,
                      arguments: widget.accessToken),
                  child: Icon(Icons.shopping_cart_outlined)),
            )
          ],
        ),
        drawer: Drawer(
          child: MyDrawer(accessToken: widget.accessToken),
        ),
        body: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                Text("${widget.accessToken}"),
              ],
            ),
            Expanded(
              child: Container(
                child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(4, (index) {
                      print(productImages[0]);
                      return Container(
                          child: InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, route_product_list,
                            //imdex+1 is product category id number
                            arguments: ScreenParameters(
                                parameter1: index + 1,
                                parameter2: widget.accessToken)),
                        child: Card(
                          child: Container(
                              child: Image.asset(productImages[index])
                              // child: Image(image: AssetImage('assets/chair_icon.imageset/chair_icon.png'),)
                              ),
                        ),
                      ));
                    })),
              ),
            )
          ],
        ),
      ),
    );
  }

  showSnackBar(String title) {
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
