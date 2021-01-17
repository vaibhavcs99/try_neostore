import 'package:flutter/material.dart';
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
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
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
                        height: MediaQuery.of(context).size.height*0.18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  width: 100,
                                  child: Image.network(orderData.prodImage),
                                )),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 17.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(orderData.prodName,
                                        style: TextStyle(fontSize: 23)),
                                    SizedBox(height: 7),
                                    Text(orderData.prodCatName),
                                    SizedBox(height: 13),
                                    Padding(
                                      padding: const EdgeInsets.only(right:14.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'QTY : ${orderData.quantity.toString()}',
                                              style: TextStyle(fontSize: 15)),
                                          SizedBox(width: 40),
                                          Text(
                                              'Rs. ${orderData.total.toString()}'),
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
              ),
              Card(
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
                        child: Text('Rs. ${snapshot.data.data.cost}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                letterSpacing: 1.2)),
                      ),
                    ],
                  ),
                ),
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
