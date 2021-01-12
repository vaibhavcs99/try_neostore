import 'package:flutter/material.dart';
import 'package:try_neostore/constants/urls.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/cart_list_model.dart';
import 'package:try_neostore/network/api_services.dart';

class CartList extends StatefulWidget {
  final ApiResponse apiResponse;

  const CartList({Key key, @required this.apiResponse}) : super(key: key);
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List itemList = <int>[1, 2, 3, 4, 5, 6, 7, 8];
  int dropDownValue = 1;

  @override
  Widget build(BuildContext context) {
    var myAccessToken = widget.apiResponse.data.accessToken;
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<CartListModel>(
            future: cartListService(receivedAccessToken: myAccessToken),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
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
                              Text(productData.product.subTotal.toString()),
                              //******************************************************
                              DropdownButton<int>(
                                value: productData.quantity,
                                items: itemList
                                    .map((e) => DropdownMenuItem<int>(
                                        value: e, child: Text('$e')))
                                    .toList(),
                                onChanged: (value) async {
                                  await editItemCartService(
                                      receivedAccessToken: myAccessToken,
                                      myProductId: productData.product.id,
                                      quantity: value);
                                  setState(() {});
                                },
                              ), //*********

                              RaisedButton(
                                onPressed: () {
                                  deleteItemCartService(
                                      receivedAccessToken:
                                          widget.apiResponse.data.accessToken,
                                      myProductId: productData.product.id);
                                  setState(() {});
                                },
                                child: Text('Remove from Cart'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
                  });
            }));
  }
}
