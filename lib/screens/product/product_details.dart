import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/utils.dart';
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
  @override
  Widget build(BuildContext context) {
    var productData = widget.productInfo;
    int selectedImage = 1; //TODO:DOESN'T WORK OUTSIDE BUILD

    return Scaffold(
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
                              addItemCartService(
                                  myProductId: productDetails.id,
                                  receivedAccessToken:
                                      widget.apiResponse.data.accessToken);
                              Navigator.pushNamed(context, route_cart_list,
                                  arguments: widget.apiResponse);
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
}
