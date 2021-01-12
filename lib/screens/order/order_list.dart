import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/data_class.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/order_list_model.dart';
import 'package:try_neostore/network/api_services.dart';
import 'package:try_neostore/screens/common/my_drawer.dart';

class MyOrders extends StatefulWidget {
  final ApiResponse apiResponse;

  const MyOrders({Key key, this.apiResponse}) : super(key: key);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
              child: MyDrawer(
            apiResponse: widget.apiResponse,
          )),
          body: Center(
              child: FutureBuilder<OrderListModel>(
                  future: orderListService(
                      myAccessToken: widget.apiResponse.data.accessToken),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    if (snapshot.data.data.length == 0)
                      return Text('Order List is empty');
                    return ListView.builder(
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (context, index) {
                        var orderData = snapshot.data.data[index];
                        return ListTile(
                          title: Text(orderData.id.toString()),
                          subtitle: Text(orderData.created),
                          trailing: Text(orderData.cost.toString()),
                          onTap: () => Navigator.pushNamed(
                              context, route_order_details,
                              arguments: ScreenParameters(parameter1: orderData.id,parameter2: widget.apiResponse) ),
                        );
                      },
                    );
                  }))),
    );
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
