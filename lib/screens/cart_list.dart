import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/utils.dart';
import 'package:try_neostore/constants/urls.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/cart_list_model.dart';

class CartList extends StatefulWidget {
  final ApiResponse apiResponse;

  const CartList({Key key, @required this.apiResponse}) : super(key: key);
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  var product_id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<CartListModel>(
            future: cartListService(),
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
                              Row(
                                children: [
                                  RaisedButton(
                                    onPressed: () {
                                      addItemCartService(
                                          myProductId: productData.product.id);
                                      setState(() {});
                                    },
                                    child: Text('Add'),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      deleteItemCartService(
                                          myProductId: productData.product.id);
                                      setState(() {});
                                    },
                                    child: Text('Remove from Cart'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
                  });
            }));
  }

  Future<CartListModel> cartListService() async {
    var dio = Dio();
    dio.options.headers['access_token'] = widget.apiResponse.data.accessToken;
    var data = await dio.get(urlListCartItems);
    final cartListModel = cartListModelFromJson(data.data);

    return cartListModel;
  }

   addItemCartService({@required int myProductId}) async {
    var dio = Dio();
    dio.options.headers['access_token'] = widget.apiResponse.data.accessToken;

    Map<String, dynamic> productData = {
      'product_id': myProductId,
      'quantity': 1
    };

    FormData formData = FormData.fromMap(productData);
    var data = await dio.post(urlAddToCart, data: formData);
    
  }

deleteItemCartService(
      {@required int myProductId}) async {
    var dio = Dio();
    dio.options.headers['access_token'] = widget.apiResponse.data.accessToken;

    Map<String, dynamic> productData = {
      'product_id': myProductId,
    };

    FormData formData = FormData.fromMap(productData);

    var data = await dio.post(urlDeleteCart, data: formData);

  }
}
