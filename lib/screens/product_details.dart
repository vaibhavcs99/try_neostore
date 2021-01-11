import 'package:flutter/material.dart';
import 'package:try_neostore/Utils/utils.dart';
import 'package:try_neostore/model/product_details.model.dart';
import 'package:try_neostore/model/product_list_model.dart';
import 'package:try_neostore/network/api_services.dart';

class ProductDetails extends StatefulWidget {
  final Datum productInfo;

  const ProductDetails({Key key, @required this.productInfo}) : super(key: key);
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
                  Column(
                    children: [
                      Column(
                        children: [
                          Container(
                                width: 250,
                                child: Image.network(productDetails
                                    .productImages[selectedImage].image)),
                          // ListView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) => Text('ok'),
                          //   )
                        ],
                      )
                    ],
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
                            onPressed: () => print('Buy Now'),
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
