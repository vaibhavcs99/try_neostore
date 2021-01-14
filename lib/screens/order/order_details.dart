import 'package:flutter/material.dart';
import 'package:try_neostore/constants/urls.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/order_details_model.dart';
import 'package:try_neostore/repository/api_services.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<OrderDetailsModel>(
        future: getMyModel(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: snapshot.data.data.orderDetails.length,
                  itemBuilder: (context, index) {
                    var orderData = snapshot.data.data.orderDetails[index];
                    return Card(
                      child: Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                              width: 100,
                              child: Image.network(orderData.prodImage),
                            )),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(orderData.prodName),
                                  Text(orderData.prodCatName),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                              orderData.quantity.toString())),
                                      SizedBox(width: 40),
                                      Expanded(
                                          child:
                                              Text(orderData.total.toString())),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Total'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Rs. ${snapshot.data.data.cost}'),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<OrderDetailsModel> getMyModel() async {
    var myJson = await orderDetailsService(
        accessToken: widget.accessToken, orderId: widget.orderId);
    var myModel = orderDetailsModelFromJson(myJson.data);
    return myModel;
  }
}
