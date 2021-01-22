import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/Utils/data_class.dart';
import 'package:try_neostore/bloc/order_list_bloc/order_list_bloc.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/screens/widgets/my_drawer.dart';

class MyOrders extends StatefulWidget {
  final String accessToken;

  const MyOrders({Key key, this.accessToken}) : super(key: key);
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrderListBloc>(context)
        .add(OnShowOrderList(accessToken: widget.accessToken));
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(
                title: Text('My Orders',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            drawer: Drawer(
                child: MyDrawer(
              accessToken: widget.accessToken,
            )),
            body: BlocBuilder<OrderListBloc, OrderListState>(
              builder: (context, state) {
                if (state is OrderListSuccessful) {
                  if (state.orderListModel.data.length == 0)
                    return Center(child: Text('No orders placed.'));

                  return buildOrderListScreen(state);
                }
                return Center(child: CircularProgressIndicator());
              },
            )));
  }

  ListView buildOrderListScreen(OrderListSuccessful state) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(thickness: 4),
      itemCount: state.orderListModel.data.length,
      itemBuilder: (context, index) {
        var orderData = state.orderListModel.data[index];

        return ListTile(
          title: Text('Order ID : ${orderData.id.toString()}'),
          subtitle: Text('Ordered Date : ${orderData.created}'),
          trailing: Text('Rs. ${orderData.cost.toString()}'),
          onTap: () => Navigator.pushNamed(context, route_order_details,
              arguments: ScreenParameters(
                  parameter1: orderData.id, parameter2: widget.accessToken)),
        );
      },
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
