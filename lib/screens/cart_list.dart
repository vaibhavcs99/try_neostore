import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';

import 'package:try_neostore/model/cart_list_model.dart';
import 'package:try_neostore/repository/api_services.dart';

class CartList extends StatefulWidget {
  final String accessToken;

  const CartList({Key key, @required this.accessToken}) : super(key: key);
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List itemList = <int>[1, 2, 3, 4, 5, 6, 7, 8];
  int dropDownValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<CartListModel>(
            future: getMyModel(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data.count == null) {
                return Center(child: Text('Cart is Empty'));
              }
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                        itemCount: snapshot.data.count,
                        itemBuilder: (context, index) {
                          var productData = snapshot.data.data[index];

                          return Card(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: ClipRRect(
                                          child: Container(
                                        child: Image.network(
                                            productData.product.productImages),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productData.product.id.toString()),
                                    Text(productData.product.name),
                                    Text(productData.product.productCategory),
                                    Text(productData.quantity.toString()),
                                    Text(productData.product.subTotal
                                        .toString()),
                                    //******************************************************
                                    DropdownButton<int>(
                                      value: productData.quantity,
                                      items: itemList
                                          .map((e) => DropdownMenuItem<int>(
                                              value: e, child: Text('$e')))
                                          .toList(),
                                      onChanged: (value) async {
                                        await editItemCartService(
                                            accessToken: widget.accessToken,
                                            myProductId: productData.product.id,
                                            quantity: value);
                                        setState(() {});
                                      },
                                    ), //*********

                                    RaisedButton(
                                      onPressed: () {
                                        deleteItemCartService(
                                            accessToken: widget.accessToken,
                                            myProductId:
                                                productData.product.id);
                                        setState(() {});
                                      },
                                      child: Text('Remove from Cart'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                        }),
                  ),
                  RaisedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, route_enter_address,arguments: widget.accessToken),
                      child: Text('Order Now'))
                ],
              );
            }));
  }
    Future<CartListModel> getMyModel() async {
    var myJson = await cartListService(accessToken: widget.accessToken);
    var myModel = cartListModelFromJson(myJson.data);
    return myModel;
  }
}
