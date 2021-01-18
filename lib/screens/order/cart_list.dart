import 'package:flutter/material.dart';
import 'package:try_neostore/constants/constants.dart';

import 'package:try_neostore/model/cart_list_model.dart';
import 'package:try_neostore/repository/api_services.dart';
import 'package:try_neostore/screens/widgets/my_button.dart';

class CartList extends StatefulWidget {
  final String accessToken;

  const CartList({Key key, @required this.accessToken}) : super(key: key);
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List itemList = <int>[1, 2, 3, 4, 5, 6, 7, 8];
  int dropDownValue = 1;
  int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        body: FutureBuilder<CartListModel>(
            future: getMyModel(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data.count == null) {
                return Center(child: Text('Cart is Empty'));
              }
              totalPrice = snapshot.data.total;
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: ListView.builder(
                        itemCount: snapshot.data.count,
                        itemBuilder: (context, index) {
                          var productData = snapshot.data.data[index];
                          
                          print(totalPrice);
                          return Dismissible(
                            key: Key(productData.product.id.toString()),
                            background: slideLeftBackground(),
                            onDismissed: (direction) {
                              deleteItemCartService(
                                  accessToken: widget.accessToken,
                                  productId: productData.product.id);
                            },
                            child: Card(
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
                                          child: Image.network(productData
                                              .product.productImages),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(productData.product.name,
                                          style: TextStyle(fontSize: 23)),
                                      Text(productData.product.productCategory),
                                      // Text(productData.product.subTotal.toString()),
                                      //******************************************************
                                      DropdownButton<int>(
                                        iconEnabledColor: Colors.black,
                                        value: productData.quantity,
                                        items: itemList
                                            .map((e) => DropdownMenuItem<int>(
                                                value: e, child: Text('$e')))
                                            .toList(),
                                        onChanged: (value) async {
                                          await editItemCartService(
                                              accessToken: widget.accessToken,
                                              productId:
                                                  productData.product.id,
                                              quantity: value);
                                          setState(() {});
                                        },
                                      ), //*********
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          );
                        }),
                  ),
                  Card(
                    child: SizedBox(
                      height: 66.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TOTAL',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    letterSpacing: 1.2)),
                            Text('Rs. $totalPrice',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                    letterSpacing: 1.2))
                          ],
                        ),
                      ),
                    ),
                  ),
                  MyButton(
                    color: primaryRed2,
                    onPressed: () => Navigator.pushNamed(
                        context, route_enter_address,
                        arguments: widget.accessToken),
                    myText: 'Order Now',
                    textColor: Colors.white,
                  )
                ],
              );
            }));
  }

  Future<CartListModel> getMyModel() async {
    var myJson = await cartListService(accessToken: widget.accessToken);
    var myModel = cartListModelFromJson(myJson.data);
    return myModel;
  }

  slideLeftBackground() {
    return Container(
        alignment: Alignment.centerRight,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                  radius: 26,
                  backgroundColor: primaryRed2,
                  child: Icon(Icons.delete, size: 36, color: Colors.white)),
              CircleAvatar(
                  radius: 26,
                  backgroundColor: primaryRed2,
                  child: Icon(Icons.delete, size: 36, color: Colors.white))
            ],
          ),
        ));
  }
}
