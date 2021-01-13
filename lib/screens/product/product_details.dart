import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/utils.dart';
import 'package:try_neostore/Utils/validators.dart';
import 'package:try_neostore/constants/constants.dart';
import 'package:try_neostore/model/api_response.dart';
import 'package:try_neostore/model/product_details.model.dart';
import 'package:try_neostore/model/product_list_model.dart';
import 'package:try_neostore/network/api_services.dart';

class ProductDetails extends StatefulWidget {
  final Datum productInfo;
  final ApiResponse apiResponse;

  const ProductDetails(
      {Key key, @required this.productInfo, @required this.apiResponse})
      : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int _quantity = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var productData = widget.productInfo;
    int selectedImage = 1; //TODO:DOESN'T WORK OUTSIDE BUILD

    return Scaffold(
        key: _scaffoldKey,
        body: FutureBuilder<ProductDetailsModel>(
            future: productDetailsService(productData.id.toString()),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              var productDetails = snapshot.data.data;
              return ListView(
                shrinkWrap: true,
                children: [
                  Card(
                    child: Column(
                      children: [
                        Text(productDetails.name),
                        Text(getProductCategoryName(
                            productDetails.productCategoryId)),
                        Text(productDetails.producer),
                      ],
                    ),
                  ),
                  Container(
                      height: 200,
                      child: Image.network(
                          productDetails.productImages[selectedImage].image)),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        try {
                          return Card(
                            child: Container(
                                width: 130,
                                child: Image.network(
                                    productDetails.productImages[index].image)),
                          );
                        } on RangeError {
                          return Card(
                              // child: Container(
                              //     width: 130,
                              //     child: Image.network(
                              //         productDetails.productImages[0].image)),
                              );
                        }
                      },
                    ),
                  ),
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24)),
                        Text(productDetails.description),
                      ],
                    ),
                  ),
                  Card(
                    child: Row(
                      children: [
                        RaisedButton(
                            onPressed: () {
                              showAlertDialog(
                                  productId: productDetails.id,
                                  productName: productDetails.name,
                                  productImageUrl:
                                      productDetails.productImages.first.image);
                              // addItemCartService(
                              //     myProductId: productDetails.id,
                              //     receivedAccessToken:
                              //         widget.apiResponse.data.accessToken);
                              // Navigator.pushNamed(context, route_cart_list,
                              //     arguments: widget.apiResponse);
                            },
                            child: Text('Buy Now')),
                        RaisedButton(
                            onPressed: () => print('Rate'),
                            child: Text('Rate')),
                      ],
                    ),
                  )
                ],
              );
            }));
  }

  void showAlertDialog(
      {@required String productName,
      @required String productImageUrl,
      @required int productId}) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(productName),
      content: SizedBox(
          width: 100,
          height: 250,
          child: Form(
            key: _formKey,
            child: ListView(children: [
              Container(
                child: Image.network(productImageUrl),
              ),
              // Text('Enter Quantity of product'),
              TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                    labelText: 'Quantity', hintText: 'Enter a quantity'),
                keyboardType: TextInputType.number,
                validator: validateQuantity,
                onSaved: (newValue) {
                  _quantity = int.parse(newValue);
                },
              )
            ]),
          )),
      actions: [
        RaisedButton(
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              await addItemCartService(
                  myProductId: productId,
                  quantity: _quantity,
                  receivedAccessToken: widget.apiResponse.data.accessToken);
              Navigator.pop(context);
              Navigator.pushNamed(context, route_cart_list,
                  arguments: widget.apiResponse);
            } else {
              // _scaffoldKey.currentState.showSnackBar(
              //     SnackBar(content: Text('Please Enter all Fields')));
            }
          },
          child: Text('Add to cart'),
        )
      ],
    );

    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }
}
