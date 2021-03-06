import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_neostore/bloc/order_details_bloc/order_details_bloc.dart';
import 'package:try_neostore/model/order_details_model.dart';
import 'package:sizer/sizer.dart';

class OrderDetails extends StatefulWidget {
  final int orderId;
  final String accessToken;
  const OrderDetails({Key key, this.orderId, this.accessToken})
      : super(key: key);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrderDetailsBloc>(context).add(OnShowOrderDetails(
        accessToken: widget.accessToken, orderId: widget.orderId));

    return Scaffold(
      appBar: AppBar(
          title: Text('Order Details',
              style: TextStyle(fontWeight: FontWeight.bold))),
      body: BlocBuilder<OrderDetailsBloc, OrderDetailsState>(
        builder: (context, state) {
          if (state is OrderDetailsSuccessful) {
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal:2.0.w),
              child: ListView(
                children: [
                  SizedBox(height: 2.0.h),
                  buildListTile(context, state.orderDetailsModel),
                  buildTotalPrice(state.orderDetailsModel),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  SizedBox buildListTile(
      BuildContext context, OrderDetailsModel orderDetailsModel) {
    return SizedBox(
      height: 70.0.h,
      child: ListView.builder(
        itemCount: orderDetailsModel.data.orderDetails.length,
        itemBuilder: (context, index) {
          var orderData = orderDetailsModel.data.orderDetails[index];
          return Card(
            child: Container(
              height: 25.0.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: Image.network(orderData.prodImage),
                      )),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding:  EdgeInsets.only(left: 6.0.w, top: 3.0.h),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(orderData.prodName,
                              style: TextStyle(fontSize: 23)),
                          SizedBox(height: 7),
                          Text(orderData.prodCatName),
                          SizedBox(height: 13),
                          Padding(
                            padding: const EdgeInsets.only(right: 14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('QTY : ${orderData.quantity.toString()}',
                                    style: TextStyle(fontSize: 15)),
                                SizedBox(width: 40),
                                Text('Rs. ${orderData.total.toString()}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Card buildTotalPrice(OrderDetailsModel orderDetailsModel) {
    return Card(
      child: SizedBox(
        height: 66,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('TOTAL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      letterSpacing: 1.2)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Rs. ${orderDetailsModel.data.cost}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      letterSpacing: 1.2)),
            ),
          ],
        ),
      ),
    );
  }
}
